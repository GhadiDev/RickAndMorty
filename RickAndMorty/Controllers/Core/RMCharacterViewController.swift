//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by  Ghadi on 23/10/2024.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
         title = "Character"
        
        let request = RMRequest(endpoint: .character,queryParameters: [URLQueryItem(name: "name", value: "rick"), URLQueryItem(name: "status", value: "alive")])
        print(request.url)
    }
    
    


}
