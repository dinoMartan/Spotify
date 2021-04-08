//
//  FeaturedPlaylistsResponse.swift
//  Spotify
//
//  Created by Dino Martan on 27/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - FeaturedPlaylistsResponse

struct FeaturedPlaylistsResponse: Codable {
    
    let message: String
    let playlists: Playlists
    
}
