//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewControllerHome = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "home")
        let viewControllerSearch = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(identifier: "search")
        let viewControllerLibrary = UIStoryboard(name: "Library", bundle: nil).instantiateViewController(identifier: "library")
        
        viewControllerHome.title = "Home"
        viewControllerSearch.title = "Search"
        viewControllerLibrary.title = "Library"
        
        let navigationControllerHome = UINavigationController(rootViewController: viewControllerHome)
        let navigationControllerSearch = UINavigationController(rootViewController: viewControllerSearch)
        let navigationControllerLibrary = UINavigationController(rootViewController: viewControllerLibrary)
        
        navigationControllerHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        navigationControllerSearch.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        navigationControllerLibrary.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 1)
        
        
        //let viewControllers: [UIViewController]? = [viewControllerHome, viewControllerSearch, viewControllerLibrary]
        let viewControllers: [UIViewController]? = [navigationControllerHome,navigationControllerSearch,navigationControllerLibrary]
        
        //self.tabBarController?.selectedIndex = 1
        setViewControllers(viewControllers, animated: true)
        
    }
    

}
