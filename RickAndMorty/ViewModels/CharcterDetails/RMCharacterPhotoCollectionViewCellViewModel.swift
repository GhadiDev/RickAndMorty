//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by  Ghadi on 30/10/2024.
//

import UIKit

final class RMCharacterPhotoCollectionViewCellViewModel{
    
    private let imageURL: URL?
    
    
    init(imageURL: URL?){
        
        self.imageURL = imageURL
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageURL = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.dawnloadImage(imageURL, completion: completion)

    }
}
