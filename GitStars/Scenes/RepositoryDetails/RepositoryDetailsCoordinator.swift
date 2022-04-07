//
//  RepositoryDetailsCoordinator.swift
//  GitStars
//
//  Created by Matheus Lenke on 05/04/22.
//

import Foundation
import UIKit

class RepositoryDetailsCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    
    let repo: Any
    
    init(navigationController: UINavigationController, repo: Repo) {
        self.navigationController = navigationController
        self.repo = repo
    }
    
    init(navigationController: UINavigationController, repo: FavoritesModel) {
        self.navigationController = navigationController
        self.repo = repo
    }
    
    
    func start() {
        let repositoryDetailsViewController = RepositoryDetailsViewController()
        let searchRepoByIdServices = SearchRepoByIdService()
        let viewModel =  RepositoryDetailsViewModel(searchRepoByIdServices: searchRepoByIdServices )
        if let repo = repo as? Repo {
            viewModel.apiRepository = repo
        }
        if let repo = repo as? FavoritesModel {
            viewModel.coreDataRepository = repo
        }
        repositoryDetailsViewController.viewModel = viewModel
        
        navigationController.pushViewController(repositoryDetailsViewController, animated: true)
    }
    
    
}
