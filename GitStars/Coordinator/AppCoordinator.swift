//
//  AppCoordinator.swift
//  GitStars
//
//  Created by Matheus Lenke on 05/04/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let mainTabBarController = MainTabBarController()
        
        window.rootViewController = mainTabBarController
        
        window.makeKeyAndVisible()
    }
}
