//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by  Ghadi on 25/10/2024.
//

import UIKit

protocol RMCharacterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacter()
    func didLoadMoreCharacter(with newIndextPath: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

/// View Model to hanlde character list view logic
final class RMCharacterListViewModel: NSObject {
    
    public weak var delegate:RMCharacterListViewModelDelegate?
    //To just fetch the datas once
    private var isLoadingMoreCharacter = false
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterImageURL: URL(string: character.image))
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    public func fetchCharacters () {
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) {[weak self] result in
            switch result {
            case .success(let responseModel):
                let result = responseModel.results
                let info = responseModel.info
                self?.characters = result
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacter()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionlCharacter(url: URL) {
        guard !isLoadingMoreCharacter else {
            return
        }
        isLoadingMoreCharacter = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacter = false
            return
        }
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result{
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap {                    return IndexPath(row: $0, section: 0)
                }
                self?.characters.append(contentsOf: moreResults)
               DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacter(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacter = false
               }
                case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreCharacter = false

                
            }
        }
    }
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}
extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unspported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unspported")

        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

// MARK -
extension RMCharacterListViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacter, !cellViewModels.isEmpty, let nextURLString = apiInfo?.next, let url = URL(string: nextURLString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){ [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHight - totalScrollViewFixedHeight - 120){
                self?.fetchAdditionlCharacter(url: url)
            }
            t.invalidate()
    
        }
        
    }
}
