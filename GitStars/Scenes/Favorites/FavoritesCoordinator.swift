//
//  FavoritesCoordinator.swift
//  GitStars
//
//  Created by Matheus Lenke on 05/04/22.
//

import Foundation
import UIKit

class FavoritesCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    var rootViewController: UINavigationController {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let favoritesViewController = FavoritesViewController()
        let searchRepoServices = SearchRepoCoreDataService()
        let viewModel =  FavoritesViewModel(searchRepoServices: searchRepoServices)
        viewModel.coordinator = self
        favoritesViewController.viewModel = viewModel
        
        navigationController.setViewControllers([favoritesViewController], animated: true)
    }
    
    func repositoryDetail(repo: Repository) {
        let repositoryDetailsCoordinator = RepositoryDetailsCoordinator(navigationController: navigationController, repo: repo)
        childCoordinators.append(repositoryDetailsCoordinator)
        repositoryDetailsCoordinator.parentCoordinator = self
        repositoryDetailsCoordinator.start()
    }
}
