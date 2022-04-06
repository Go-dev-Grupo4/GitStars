//
//  HomeCoordinator.swift
//  GitStars
//
//  Created by Matheus Lenke on 05/04/22.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    var rootViewController: UINavigationController {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let homeViewController = HomeViewController()
        let searchRepoServices = SearchRepoService()
        let viewModel =  HomeViewModel(searchRepoServices: searchRepoServices)
        viewModel.coordinator = self
        homeViewController.viewModel = viewModel
        
        navigationController.setViewControllers([homeViewController], animated: true)
    }
    
    func repositoryDetail(repo: Repo) {
        let repositoryDetailsCoordinator = RepositoryDetailsCoordinator(navigationController: navigationController, repo: repo)
        childCoordinators.append(repositoryDetailsCoordinator)
        repositoryDetailsCoordinator.parentCoordinator = self
        repositoryDetailsCoordinator.start()
    }
    
    
}
