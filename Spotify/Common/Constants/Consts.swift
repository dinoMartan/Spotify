//
//  Constants.swift
//  Spotify
//
//  Created by Dino Martan on 21/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

struct AlertsConstants {

    enum Titles: String {
        
        case ops = "Oooops!"
        case somethingWentWrong = "Something went wrong!"
        case error = "Error"
        
    }
    
    enum Messages: String {
        
        case didntSignIn = "Looks like you didn't sign in"
        case didntCompleteAPICall = "Didn't complete API call!"
        case didntFetchUserProfile = "Looks like we couldn't fetch your profile data"
        case didntFetchFeaturedPlaylists = "Looks like we couldn't fetch featured playlists"
        case didntFetchNewReleases = "Looks like we couldn't fetch new releases"
        case didntFetchRecommendationGenres = "Looks like we couldn't fetch recommendation genres"
        case didntFetchRecommendations = "Looks like we couldn't fetch recommendations"
        case didntCreatePlaylist = "Looks like we couldn't create your playlist"
        case areYouSureYouWantToDeleteThisPlaylist = "Are you sure you want to delete this playlist? This action can't be undone."
        
    }
    
    enum Button: String {
        
        case shame = "Shame"
        case ok = "OK"
        case cancel = "Cancel"
        
    }
    
}

enum ConstantsImages {
    
    struct Images {
        
        static let house = UIImage(systemName: "house")
        static let magnifyingGlass = UIImage(systemName: "magnifyingglass")
        static let musicNote = UIImage(systemName: "music.note.list")
        
    }
    
}

enum SettingsConstants {
    
    struct Keys {
        
        static let settingsCell = "settingsCell"
        
    }
    
}

enum ColorsConstants {
    
    static let colors: [UIColor] = [
        .systemRed, .systemBlue, .systemPink, .systemTeal, .systemGray,
        .systemOrange, .systemYellow, .systemPurple, .systemGreen, .systemIndigo
    ]
    
}


enum PlayerConstants {
    
    static let defaultTrackVolume: Float = 0.5
    
}
