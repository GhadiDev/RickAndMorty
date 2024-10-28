//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by  Ghadi on 25/10/2024.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable {
  
    
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
  
    
    //MARK - init
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageURL: URL?) {
        
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    //Download an image, request steps
    public func fetchImage(completion: @escaping (Result <Data, Error>) -> Void) {
        
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        RMImageLoader.shared.dawnloadImage(url, completion: completion)
    }
    // MARK - hash (check if the Collection View have if or not)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
