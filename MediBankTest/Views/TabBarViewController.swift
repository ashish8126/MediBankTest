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
    
    private enum ScreenTitle: String {
        case headlines = "Headlines"
        case sources = "Sources"
        case saved = "Saved"
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
        let headlinesBarItem = UITabBarItem(title: ScreenTitle.headlines.rawValue, image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        headlinesViewController.tabBarItem = headlinesBarItem
        
        let sourcesBarItem = UITabBarItem(title: ScreenTitle.sources.rawValue, image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        sourcesListViewController.tabBarItem = sourcesBarItem
        
        let savedBarItem = UITabBarItem(title: ScreenTitle.saved.rawValue, image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        savedListViewController.tabBarItem = savedBarItem
        
        self.viewControllers = [headlinesViewController, sourcesListViewController, savedListViewController]
    }
    
}

