//
//  APIConstants.swift
//  Spotify
//
//  Created by Dino Martan on 27/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

private let apiUrl = "https://api.spotify.com/v1"

enum APIConstants {
    
    static let currentUserProfileUrl = "\(apiUrl)/me"
    static let newReleasesUrl = "\(apiUrl)/browse/new-releases"
    static let featuredPlaylistsUrl = "\(apiUrl)/browse/featured-playlists"
    static let recommendationsUrl = "\(apiUrl)/recommendations"
    static let recommendationGenresUrl = "\(apiUrl)/recommendations/available-genre-seeds"
    static let albumDetailsUrl = "\(apiUrl)/albums/"
    static let playlistUrl = "\(apiUrl)/playlists/"
    static let allCagetoriesUrl = "\(apiUrl)/browse/categories"
    static let categoryPlaylistsUrl = "\(apiUrl)/browse/categories/"
    static let searchUrl = "\(apiUrl)/search"
    static let currentUserPlaylists = "\(apiUrl)/me/playlists"
    static let createPlaylistUrl = "\(apiUrl)/users/"
    static let artistsUrl = "\(apiUrl)/artists"
    
}

struct APIParameters {
    
    static let newReleases = [
        "limit": 50
    ]
    
    static let featuredPlaylists = [
        "limit": 50
    ]
    
    static let allCategories = [
        "limit": 50
    ]
    
}
