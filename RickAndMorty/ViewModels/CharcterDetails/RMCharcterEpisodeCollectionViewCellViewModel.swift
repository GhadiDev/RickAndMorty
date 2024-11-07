//
//  RMCharcterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by  Ghadi on 30/10/2024.
//

import UIKit

protocol RMEdisodeDataRender {
    var name: String {get}
    var air_date: String {get}
    var episode: String {get}
}
final class RMCharcterEpisodeCollectionViewCellViewModel: Hashable, Equatable{
 
    public let borderColor: UIColor
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock: ((RMEdisodeDataRender) -> Void)?
    private var episode: RMEpisode? {
        didSet{
            guard let model = episode else {
                return
            }
           dataBlock?(model)
        }
    }
    
    init(episodeDataUrl: URL?, borderColor: UIColor = .systemBlue) {
        self.episodeDataUrl = episodeDataUrl
        self.borderColor = borderColor
    }
    
    public func registerForData(_ block: @escaping (RMEdisodeDataRender) -> Void){
        self.dataBlock = block
    }
    /// Fetch backing episode model
       public func fetchEpisode() {
           guard !isFetching else {
               if let model = episode {
                   dataBlock?(model)
               }
               return
           }
           guard let url = episodeDataUrl, let request = RMRequest(url: url) else{
               return
           }
           isFetching = true
           RMService.shared.execute(request, expecting: RMEpisode.self) {[weak self] result in
               switch result {
               case .success(let model):
                   DispatchQueue.main.async {
                       self?.episode = model
                   }
               case .failure(let failure):
                   print(String(describing: failure))
               }
           }
          
       }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
        }

        static func == (lhs: RMCharcterEpisodeCollectionViewCellViewModel, rhs: RMCharcterEpisodeCollectionViewCellViewModel) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    
}
