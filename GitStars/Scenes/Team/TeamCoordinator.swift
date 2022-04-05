//
//  TeamCoordinator.swift
//  GitStars
//
//  Created by Matheus Lenke on 05/04/22.
//

import Foundation

import UIKit

class TeamCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    var rootViewController: UINavigationController {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let teamViewController = TeamViewController()
        
        navigationController.setViewControllers([teamViewController], animated: true)
    }
    
    func teamDetail(dev: Developer) {
        let teamDetailsCoordinator = TeamDetailsCoordinator(navigationController: navigationController, dev: dev)
        childCoordinators.append(teamDetailsCoordinator)
        teamDetailsCoordinator.parentCoordinator = self
        teamDetailsCoordinator.start()
    }
}
