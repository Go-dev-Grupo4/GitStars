//
//  AppCoordinator.swift
//  GitStars
//
//  Created by Matheus Lenke on 05/04/22.
//

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
        
        UserDefaults.standard.set(false, forKey: Constants.UserDefaultsConstants.userDidOnboardingKey)
        
        let userDidOnboarding = UserDefaults.standard.bool(forKey: Constants.UserDefaultsConstants.userDidOnboardingKey)
        
        if userDidOnboarding == false {
            flowOnboarding(mainTabBar: mainTabBarController)
        }
    }
    
    func flowOnboarding(mainTabBar: MainTabBarController) {
        let onboardingViewController = OnboardingViewController()
        mainTabBar.present(onboardingViewController, animated: true) {
        }
    }
}
