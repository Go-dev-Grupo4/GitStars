//
//  TeamDetailCoordinator.swift
//  GitStars
//
//  Created by Matheus Lenke on 05/04/22.
//

import Foundation
import UIKit

class TeamDetailsCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    
    let dev: Developer
    
    init(navigationController: UINavigationController, dev: Developer) {
        self.navigationController = navigationController
        self.dev = dev
    }

    func start() {
        let teamDetailsViewController = TeamDetailsViewController()
        teamDetailsViewController.dev = dev
        
        navigationController.pushViewController(teamDetailsViewController, animated: true)
    }
    
    
}

