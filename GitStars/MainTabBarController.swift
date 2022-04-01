//
//  MainTabBarController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    lazy var homeNavigationController: UINavigationController! = {
        let searchRepoService = SearchRepoService()
        let repoViewModel = RepoViewModel(searchRepoServices: searchRepoService)
        let homeViewController = HomeViewController()
        homeViewController.viewModel = repoViewModel
        
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        let itemBar = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()
    
    lazy var favoritesNavigationController: UINavigationController! = {
        let navigationController = UINavigationController(rootViewController: FavoritesViewController())
        
        let itemBar = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "star.fill"), tag: 1)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()
    
    lazy var teamNavigationController: UINavigationController! = {
        let navigationController = UINavigationController(rootViewController: TeamViewController())
        
        let itemBar = UITabBarItem(title: "Time", image: UIImage(systemName: "person.3.fill"), tag: 2)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([homeNavigationController, favoritesNavigationController, teamNavigationController], animated: true)

        UITabBar.appearance().tintColor = UIColor.label
        UITabBar.appearance().backgroundColor = .systemBackground
    }
}
