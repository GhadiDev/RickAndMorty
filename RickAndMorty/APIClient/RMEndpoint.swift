//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by  Ghadi on 23/10/2024.
//

import Foundation


/// Represents unique API endpoint
@frozen enum RMEndpoint: String{
    /// Endpoint to get location into
    case Location
    /// Endpoint to get character into
    case Character
    /// Endpoint to get episode into
    case Episode
}
