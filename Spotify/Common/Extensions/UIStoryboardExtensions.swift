//
//  UIStoryboardExtensions.swift
//  Spotify
//
//  Created by Dino Martan on 21/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum Name: String {
        
        case main = "Main"
        case home = "Home"
        case search = "Search"
        case library = "Library"
        case authentication = "Authentication"
        case welcome = "Welcome"
        case settings = "Settings"
        case profile = "Profile"
        case album = "Album"
        case playlist = "Playlist"
        
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
        case album = "album"
        case playlist = "playlist"
        
    }
    
    
    enum Storyboard {
        
        case home
        case main
        case search
        case library
        case authentication
        case welcome
        case settings
        case profile
        case album
        case playlist
        
        var viewController: UIViewController {
            switch self {
            case .home: return instantiateViewController(name: .home, identifier: .home)
            case .main: return instantiateViewController(name: .main, identifier: .main)
            case .search: return instantiateViewController(name: .search, identifier: .search)
            case .library: return instantiateViewController(name: .library, identifier: .library)
            case .authentication: return instantiateViewController(name: .authentication, identifier: .authentication)
            case .welcome: return instantiateViewController(name: .welcome, identifier: .welcome)
            case .settings: return instantiateViewController(name: .settings, identifier: .settings)
            case .profile: return instantiateViewController(name: .profile, identifier: .profile)
            case .album: return instantiateViewController(name: .album, identifier: .album)
            case .playlist: return instantiateViewController(name: .playlist, identifier: .playlist)
            }
        }
        
    }

    private static func instantiateViewController(name: Name, identifier: Identifier) -> UIViewController {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: identifier.rawValue)
        return viewController
    }
    
}
