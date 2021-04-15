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
        case player = "Player"
        case createPlaylist = "CreatePlaylist"
        case track = "Track"
        case artist = "Artist"
        
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
        case categoryPlaylists = "categoryPlaylists"
        case player = "player"
        case createPlaylist = "createPlaylist"
        case track = "track"
        case libraryPage = "libraryPageViewController"
        case artist = "artist"
        
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
        case categoryPlaylists
        case player
        case createPlaylist
        case track
        case libraryPage
        case artist

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
            case .categoryPlaylists: return instantiateViewController(name: .search, identifier: .categoryPlaylists)
            case .player: return instantiateViewController(name: .player, identifier: .player)
            case .createPlaylist: return instantiateViewController(name: .createPlaylist, identifier: .createPlaylist)
            case .track: return instantiateViewController(name: .track, identifier: .track)
            case .libraryPage: return instantiateViewController(name: .library, identifier: .libraryPage)
            case .artist: return instantiateViewController(name: .artist, identifier: .artist)
            }
        }
        
    }

    private static func instantiateViewController(name: Name, identifier: Identifier) -> UIViewController {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: identifier.rawValue)
        return viewController
    }
    
}
