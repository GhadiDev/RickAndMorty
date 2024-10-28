//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by  Ghadi on 24/10/2024.
//

import Foundation

enum RMCharacterStatus: String, Codable {
   
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive,.dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
