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
        let viewControllerHome = UIStoryboard.instantiateViewController(name: .home, identifier: .home)
        let viewControllerSearch = UIStoryboard.instantiateViewController(name: .search, identifier: .search)
        let viewControllerLibrary = UIStoryboard.instantiateViewController(name: .library, identifier: .library)
        
        viewControllerHome.title = "Home"
        viewControllerSearch.title = "Search"
        viewControllerLibrary.title = "Library"
        
        let navigationControllerHome = UINavigationController(rootViewController: viewControllerHome)
        let navigationControllerSearch = UINavigationController(rootViewController: viewControllerSearch)
        let navigationControllerLibrary = UINavigationController(rootViewController: viewControllerLibrary)
        
        navigationControllerHome.tabBarItem = UITabBarItem(title: "Home", image: ConstantsImages.Images.house, tag: 1)
        navigationControllerSearch.tabBarItem = UITabBarItem(title: "Search", image: ConstantsImages.Images.magnifyingGlass, tag: 2)
        navigationControllerLibrary.tabBarItem = UITabBarItem(title: "Library", image: ConstantsImages.Images.musicNote, tag: 3)
        
        let viewControllers = [navigationControllerSearch, navigationControllerHome, navigationControllerLibrary]
        
        setViewControllers(viewControllers, animated: true)
        selectedIndex = 1
    }
}
