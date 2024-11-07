//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by  Ghadi on 23/10/2024.
//

import Foundation


/// Represents unique API endpoint
@frozen enum RMEndpoint: String, Hashable, CaseIterable{
    /// Endpoint to get character info
        case character
        /// Endpoint to get location info
        case location
        /// Endpoint to get episode info
        case episode
}
