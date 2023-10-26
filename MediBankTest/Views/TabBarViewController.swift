//
//  TabBarViewController.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    private let headlinesCoordinator = HeadlinesCoordinator()
    private var headlinesViewController: UIViewController {
        return self.headlinesCoordinator.rootViewController
    }
    
    private let sourcesCoordinator = SourcesCoordinator()
    private var sourcesListViewController: UIViewController {
        return self.sourcesCoordinator.rootViewController
    }
    private let savedListCoordinator = SavedListCoordinator()
    private var savedListViewController: UIViewController {
        return self.savedListCoordinator.rootViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Headlines"
        setupTabs()
        headlinesCoordinator.start()
        sourcesCoordinator.start()
        savedListCoordinator.start()
    }
    
    private func setupTabs() {
        let headlinesBarItem = UITabBarItem(title: "Headlines", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        headlinesViewController.tabBarItem = headlinesBarItem
        
        let sourcesBarItem = UITabBarItem(title: "Sources", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        sourcesListViewController.tabBarItem = sourcesBarItem
        
        let savedBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        savedListViewController.tabBarItem = savedBarItem
        
        self.viewControllers = [headlinesViewController, sourcesListViewController, savedListViewController]
    }
    
}

