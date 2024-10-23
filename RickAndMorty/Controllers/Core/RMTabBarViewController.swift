//
//  ViewController.swift
//  RickAndMorty
//
//  Created by  Ghadi on 23/10/2024.
//

import UIKit

final class RMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs (){
        
        let locationVC = RMLocationViewController()
        let characterVC = RMCharacterViewController()
        let episodeVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic

        let navigation1 = UINavigationController(rootViewController: locationVC)
        let navigation2 = UINavigationController(rootViewController: characterVC)
        let navigation3 = UINavigationController(rootViewController: episodeVC)
        let navigation4 = UINavigationController(rootViewController: settingsVC)
        
        navigation1.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "globe"), tag: 1)
        navigation2.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person"), tag: 2)
        navigation3.tabBarItem = UITabBarItem(title: "Episode", image: UIImage(systemName: "tv"), tag: 3)
        navigation4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)

        for nav in [navigation1,navigation2,navigation3,navigation4]{
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers([navigation1,navigation2,navigation3,navigation4], animated: true )
    }

}

