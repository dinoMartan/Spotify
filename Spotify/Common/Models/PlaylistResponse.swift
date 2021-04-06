//
//  PlaylistResponse.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - PlaylistResponse

struct PlaylistResponse: Codable {
    
    let collaborative: Bool
    let welcomeDescription: String
    let externalUrls: ExternalUrls
    let followers: Followers
    let href: String
    let id: String
    let images: [WelcomeImage]
    let name: String
    let owner: Owner
    let welcomePublic: Bool?
    let snapshotID: String
    let tracks: PlaylistTracks
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case collaborative
        case welcomeDescription = "description"
        case externalUrls = "external_urls"
        case followers
        case href
        case id
        case images
        case name
        case owner
        case welcomePublic = "public"
        case snapshotID = "snapshot_id"
        case tracks
        case type
        case uri
        
    }
    
}

// MARK: - WelcomeImage

struct WelcomeImage: Codable {
    
    let url: String
    
}

// MARK: - Tracks

struct PlaylistTracks: Codable {
    
    let href: String
    let items: [PlaylistTrackItem]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: Int?
    let total: Int
    
}

// MARK: - Item

struct PlaylistTrackItem: Codable {
    
    let addedAt: String
    let addedBy: Owner
    let isLocal: Bool
    let track: PlaylistTrack

    enum CodingKeys: String, CodingKey {
        
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case track
        
    }
    
}

// MARK: - Track

struct PlaylistTrack: Codable {
    
    let album: Album
    let artists: [Owner]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: PlaylistExternalIDS
    let externalUrls: ExternalUrls
    let href: String
    let id, name: String
    let popularity: Int
    let previewURL: String?
    let trackNumber: Int
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href
        case id
        case name
        case popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type
        case uri
        
    }
}

// MARK: - Album

struct Album: Codable {
    
    let albumType: String
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [AlbumImage]
    let name: String
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href
        case id
        case images
        case name
        case type
        case uri
        
    }
    
}

// MARK: - AlbumImage

struct AlbumImage: Codable {
    
    let height: Int
    let url: String
    let width: Int
    
}

// MARK: - ExternalIDS

struct PlaylistExternalIDS: Codable {
    
    let isrc: String
    
}
