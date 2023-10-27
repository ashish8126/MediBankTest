//
//  SavedListCoordinator.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 27/10/23.
//

import Foundation
import SwiftCoordinator

class SavedListCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let savedListViewController: SavedListViewController
    
    init() {
        savedListViewController = SavedListViewController()
        
        let navigationController = UINavigationController(rootViewController: savedListViewController)
        
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        savedListViewController.delegate = self
    }
}

extension SavedListCoordinator: SavedListViewControllerDelegate {
    func didTapSavedList(article: ArticleEntity) {
        let headLineDetailViewController = HeadLineDetailViewController()
        headLineDetailViewController.articleData = article
        headLineDetailViewController.viewType = .saved
        navigator.push(headLineDetailViewController, animated: true)
    }
}
