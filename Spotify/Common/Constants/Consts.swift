//
//  Constants.swift
//  Spotify
//
//  Created by Dino Martan on 21/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

struct ConstantsAlerts {

    enum Titles: String {
        case ops = "Oooops!"
        case somethingWentWrong = "Something went wrong!"
        case error = "Error"
    }
    
    enum Messages: String {
        case didntSignIn = "Looks like you didn't sign in"
        case didntCompleteAPICall = "Didn't complete API call!"
        case didntFetchUserProfile = "Looks like we couldn't fetch your profile data"
    }
    
    enum Button: String {
        case shame = "Shame"
        case ok = "OK"
    }
    
}

enum ConstantsImages {
    
    struct Images {
        static let house = UIImage(systemName: "house")
        static let magnifyingGlass = UIImage(systemName: "magnifyingglass")
        static let musicNote = UIImage(systemName: "music.note.list")
    }
    
}

struct APIUrl {
    
    static let currentUsersProfile = "https://api.spotify.com/v1"
    
}

enum Defaults: String {
    case a  = "huh"
}
