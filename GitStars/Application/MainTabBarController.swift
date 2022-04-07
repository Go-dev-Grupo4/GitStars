//
//  MainTabBarController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Coordinators
    
    private var homeCoordinator: HomeCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?
    private var teamCoordinator: TeamCoordinator?
    
    // MARK: - ViewControllers
    private var homeViewController: UIViewController? {
        return self.homeCoordinator?.rootViewController
    }
    
    private var favoritesViewController: UIViewController? {
        return self.favoritesCoordinator?.rootViewController
    }
    
    private var teamViewController: UIViewController? {
        return self.teamCoordinator?.rootViewController
    }
    
    // MARK: - NavigationControllers with Tab icons
    
    lazy var homeNavigationController: UINavigationController! = {
        let navigationController = UINavigationController()
        
        let itemBar = UITabBarItem(title: NSLocalizedString("homeTabBarTitle", comment: ""), image: UIImage(systemName: "house.fill"), tag: 0)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()
    
    lazy var favoritesNavigationController: UINavigationController! = {
        let navigationController = UINavigationController()
        
        let itemBar = UITabBarItem(title: NSLocalizedString("favoriteTabBarTitle", comment: ""), image: UIImage(systemName: "star.fill"), tag: 1)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()
    
    lazy var teamNavigationController: UINavigationController! = {
        let navigationController = UINavigationController()
        
        let itemBar = UITabBarItem(title: NSLocalizedString("teamTabBarTitle", comment: ""), image: UIImage(systemName: "person.3.fill"), tag: 2)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()
    
    lazy var appearence: UINavigationBarAppearance = {
        var appearence = UINavigationBarAppearance()
        appearence.shadowColor = Colors.secondaryBackgoundColor
        appearence.backgroundColor = Colors.secondaryBackgoundColor
        appearence.titleTextAttributes = [.foregroundColor: Colors.tintTabBarItem ?? UIColor.label]
        return appearence
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCoordinators()
        setupViewControllers()
        configUI()
        
        self.delegate = self
    }
    
    // MARK: - Private functions
    
    private func configUI() {
        UITabBar.appearance().tintColor = Colors.tintTabBarItem
        UITabBar.appearance().unselectedItemTintColor = Colors.standartTabBarItem
        UITabBar.appearance().backgroundColor = .systemBackground
        setupNavigationBar()
    }
    
    private func setupCoordinators() {
        homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        homeCoordinator?.start()
        
        favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController)
        favoritesCoordinator?.start()
        
        teamCoordinator = TeamCoordinator(navigationController: teamNavigationController)
        teamCoordinator?.start()
    }
    
    private func setupViewControllers() {
        if let homeViewController = homeViewController,
           let favoritesViewController = favoritesViewController,
           let teamViewController = teamViewController {
            setViewControllers([homeViewController, favoritesViewController, teamViewController], animated: true)
        }
    }
    
    private func setupNavigationBar() {
        homeNavigationController.navigationBar.tintColor = Colors.tintTabBarItem
        favoritesNavigationController.navigationBar.tintColor = Colors.tintTabBarItem
        teamNavigationController.navigationBar.tintColor = Colors.tintTabBarItem
        
        homeNavigationController.navigationBar.standardAppearance = appearence
        favoritesNavigationController.navigationBar.standardAppearance = appearence
        teamNavigationController.navigationBar.standardAppearance = appearence
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController : UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ViewControllerAnimation(fromIndex: fromVC.tabBarItem.tag, toIndex: toVC.tabBarItem.tag)
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

class ViewControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var toIndex: Int
    var fromIndex: Int
    
    required init(fromIndex: Int, toIndex: Int) {
        
        self.fromIndex = fromIndex
        self.toIndex = toIndex
        super.init()
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVc = transitionContext.view(forKey: .to) else { return }
        
        if fromIndex < toIndex {
            toVc.transform = CGAffineTransform(translationX: toVc.frame.width, y: 0)
        } else {
            toVc.transform = CGAffineTransform(translationX: -toVc.frame.width, y: 0)
        }
        
        transitionContext.containerView.addSubview(toVc)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVc.transform = .identity
            
        }, completion: {transitionContext.completeTransition($0)})
    }
}
