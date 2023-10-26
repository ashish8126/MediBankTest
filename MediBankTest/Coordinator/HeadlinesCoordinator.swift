//
//  HeadlinesCoordinator.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 27/10/23.
//

import Foundation
import SwiftCoordinator

class HeadlinesCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let headlinesViewController: HeadlinesListViewController
    
    init() {
        headlinesViewController = HeadlinesListViewController()
        
        let navigationController = UINavigationController(rootViewController: headlinesViewController)
        
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        headlinesViewController.delegate = self
    }
}
extension HeadlinesCoordinator: HeadlinesViewControllerDelegate {
    
    func didTapHeadline(article: ArticleEntity) {
        
        let headLineDetailViewController = HeadLineDetailViewController()
        headLineDetailViewController.articleData = article
        navigator.push(headLineDetailViewController, animated: true)
    }
    
}
