//
//  Coordinator.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 26/10/23.
//

import UIKit
import SwiftCoordinator

final class AppCoordinator: PresentationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController = TabBarViewController()

    init(window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func start() {
    }
}
