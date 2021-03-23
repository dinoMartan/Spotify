//
//  UIViewControllerExtensions.swift
//  Spotify
//
//  Created by Dino Martan on 21/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    struct MyViewControllers {
        static let mainViewController = UIStoryboard.MyBoards.mainStoryboard.instantiateViewController(identifier: "main") as TabBarViewController
        
        static let homeViewController = UIStoryboard.MyBoards.homeStoryboard.instantiateViewController(identifier: "home") as HomeViewController
        static let searchViewController = UIStoryboard.MyBoards.searchStoryboard.instantiateViewController(identifier: "search") as SearchViewController
        static let libraryViewController = UIStoryboard.MyBoards.libraryStoryboard.instantiateViewController(identifier: "library") as LibraryViewController
        
        static let authViewController = UIStoryboard.MyBoards.authStoryboard.instantiateViewController(identifier: "authentication") as AuthenticationViewController
        static let welcomeViewController = UIStoryboard.MyBoards.welcomeStoryboard.instantiateViewController(withIdentifier: "welcome")
        static let profileViewController = UIStoryboard.MyBoards.profileStoryboard.instantiateViewController(withIdentifier: "profile")
    }
    
}
