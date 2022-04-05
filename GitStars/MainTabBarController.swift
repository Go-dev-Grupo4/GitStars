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
        let repoViewModel = HomeViewModel(searchRepoServices: searchRepoService)
        let homeViewController = HomeViewController()
        homeViewController.viewModel = repoViewModel
        
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        let itemBar = UITabBarItem(title: NSLocalizedString("homeTabBarTitle", comment: ""), image: UIImage(systemName: "house.fill"), tag: 0)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()
    
    lazy var favoritesNavigationController: UINavigationController! = {
        let searchRepoService = SearchRepoCoreDataService()
        let favoriteViewModel = FavoritesViewModel(searchRepoServices: searchRepoService)
        let rootViewController = FavoritesViewController()
        rootViewController.viewModel = favoriteViewModel
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        let itemBar = UITabBarItem(title: NSLocalizedString("favoriteTabBarTitle", comment: ""), image: UIImage(systemName: "star.fill"), tag: 1)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()
    
    lazy var teamNavigationController: UINavigationController! = {
        let navigationController = UINavigationController(rootViewController: TeamViewController())
        
        let itemBar = UITabBarItem(title: NSLocalizedString("teamTabBarTitle", comment: ""), image: UIImage(systemName: "person.3.fill"), tag: 2)
        navigationController.tabBarItem = itemBar
        
        return navigationController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        configUI()
        
        self.delegate = self
    }
    
    private func configUI() {
        UITabBar.appearance().tintColor = UIColor.label
        UITabBar.appearance().backgroundColor = .systemBackground
    }
    
    private func setupViewControllers() {
        setViewControllers([homeNavigationController, favoritesNavigationController, teamNavigationController], animated: true)
    }
}

extension MainTabBarController : UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        return ViewControllerAnimation(fromIndex: fromVC.tabBarItem.tag, toIndex: toVC.tabBarItem.tag)
    }
}

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
