//
//  UIStoryboardExtensions.swift
//  Spotify
//
//  Created by Dino Martan on 21/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    struct MyStoryboard {
        
        enum Name: String {
            case main = "Main"
            case home = "Home"
            case search = "Search"
            case library = "Library"
            case authentication = "Authentication"
            case welcome = "Welcome"
            case settings = "Settings"
            case profile = "Profile"
        }
        
        enum Identifier: String {
            case main = "main"
            case home = "home"
            case search = "search"
            case library = "library"
            case authentication = "authentication"
            case welcome = "welcome"
            case settings = "settings"
            case profile = "profile"
        }
        
    }
    
    static func instantiateViewController(name: MyStoryboard.Name, identifier: MyStoryboard.Identifier) -> UIViewController {
        let storyboardName = name.rawValue
        let viewControllerIdentifier = identifier.rawValue
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: viewControllerIdentifier)
        return viewController
    }
    
}
