//
//  SourcesCoordinator.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 27/10/23.
//

import Foundation
import SwiftCoordinator

class SourcesCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let sourcesListViewController: SourcesListViewController
    
    init() {
        sourcesListViewController = SourcesListViewController()
        
        let navigationController = UINavigationController(rootViewController: sourcesListViewController)
        
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        
    }
}
