//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by  Ghadi on 23/10/2024.
//

import Foundation


struct RMEpisode: Codable, RMEdisodeDataRender {
   let id: Int
   let name: String
   let air_date: String
   let episode: String
   let characters: [String]
   let url: String
   let created: String
}
