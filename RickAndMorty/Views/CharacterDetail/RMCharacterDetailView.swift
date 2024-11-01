//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by  Ghadi on 27/10/2024.
//

import UIKit

/// View for single character info
final class RMCharacterDetailView: UIView {

    private let viewModel: RMCharacterDetailViewViewModel
    public var collectionView: UICollectionView?
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK - init
    
     init(frame: CGRect, viewModel: RMCharacterDetailViewViewModel) {
         self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView,spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        
        guard let collectionView = collectionView else {
            return
        }
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndx, _ in
            return self.createSection(for: sectionIndx)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(RMCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifer)
        collectionView.register(RMCharcterInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharcterInfoCollectionViewCell.cellIdentifer)
        collectionView.register(RMCharcterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharcterEpisodeCollectionViewCell.cellIdentifer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    private func createSection(for sectionIndx: Int) -> NSCollectionLayoutSection {
        
        let sectionType = viewModel.sections
        switch sectionType[sectionIndx] {
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .episodes:
            return viewModel.createEpisodesSectionLayout()
        case .information:
            return viewModel.createInfoSectionLayout()
        }
       
    }
   
    
}
