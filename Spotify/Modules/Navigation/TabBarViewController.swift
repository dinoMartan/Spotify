//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
        
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    func setupView() {
        tabBar.tintColor = .systemGreen
        let viewControllers = [setupSearch(), setupHome(), setupLibrary()]
        setViewControllers(viewControllers, animated: true)
        selectedIndex = 1
    }
}

//MARK: - Private extensions -

private extension TabBarViewController {
    
    private func setupHome() -> UIViewController {
        let viewControllerHome = UIStoryboard.Storyboard.home.viewController
        viewControllerHome.title = "Home"
        let navigationControllerHome = UINavigationController(rootViewController: viewControllerHome)
        navigationControllerHome.tabBarItem = UITabBarItem(title: "Home", image: ConstantsImages.Images.house, tag: 1)
        navigationControllerHome.navigationBar.tintColor = .systemGray
        return navigationControllerHome
    }
    
    private func setupSearch() -> UIViewController{
        let viewControllerSearch = UIStoryboard.Storyboard.search.viewController
        viewControllerSearch.title = "Search"
        let navigationControllerSearch = UINavigationController(rootViewController: viewControllerSearch)
        navigationControllerSearch.tabBarItem = UITabBarItem(title: "Search", image: ConstantsImages.Images.magnifyingGlass, tag: 2)
        return navigationControllerSearch
    }
    
    private func setupLibrary() -> UIViewController {
        let viewControllerLibrary = UIStoryboard.Storyboard.library.viewController
        viewControllerLibrary.title = "Library"
        let navigationControllerLibrary = UINavigationController(rootViewController: viewControllerLibrary)
        navigationControllerLibrary.tabBarItem = UITabBarItem(title: "Library", image: ConstantsImages.Images.musicNote, tag: 3)
        return navigationControllerLibrary
    }
    
}
