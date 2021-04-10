//
//  Playlists.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - Playlists

struct Playlists: Codable {
    
    let href: String
    let items: [PlaylistItem]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: Int?
    let total: Int
    
}

// MARK: - Item

struct PlaylistItem: Codable {
    
    let collaborative: Bool
    let itemDescription: String
    let externalUrls: ExternalUrls?
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let owner: Owner?
    let itemPublic: Bool?
    let snapshotID: String
    let tracks: Tracks?
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case collaborative
        case itemDescription = "description"
        case externalUrls = "external_urls"
        case href
        case id
        case images
        case name
        case owner
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks
        case type
        case uri
        
    }

    // MARK: - Tracks
    
    struct Tracks: Codable {
        
        let href: String
        let total: Int
        
    }
    
}
