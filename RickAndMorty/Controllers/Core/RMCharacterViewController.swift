//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by  Ghadi on 23/10/2024.
//

import UIKit

/// Controller to show and search for characters
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate{
   
    

    //Make instance from the view we want to added
    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
         title = "Character"
       setUpView()
        
    }
    
    private func setUpView(){
        
        characterListView.delegate = self
         view.addSubview(characterListView)
         //To make a constraints
         NSLayoutConstraint.activate([
             characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
             characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
             characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         ])
    }

    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailsVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailsVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailsVC, animated: true)
    }

}
