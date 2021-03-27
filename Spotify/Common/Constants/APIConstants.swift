//
//  APIConstants.swift
//  Spotify
//
//  Created by Dino Martan on 27/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

private let apiUrl = "https://api.spotify.com/v1"

struct APIConstants {
    
    static let currentUserProfileUrl = "\(apiUrl)/me"
    static let newReleasesUrl = "\(apiUrl)/browse/new-releases"
    static let featuredPlaylistsUrl = "\(apiUrl)/browse/featured-playlists"
    static let recommendationsUrl = "\(apiUrl)/browse/v1/recommendations"
    
}

struct APIParameters {
    
    static let newReleases = [
        "limit": 50
    ]
    
    static let featuredPlaylists = [
        "limit": 50
    ]
    
}
