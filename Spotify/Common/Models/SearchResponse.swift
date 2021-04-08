//
//  SearchResponse.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - SearchResponse

struct SearchResponse: Codable {
    
    let albums: SearchAlbums
    let artists: SearchArtists
    let tracks: SearchTracks
    let playlists: SearchPlaylists
    
}

// MARK: - Albums -

struct SearchAlbums: Codable {
    
    let href: String
    let items: [SearchAlbumElement]
    let limit: Int
    let next: String
    let offset: Int
    let previous: Int?
    let total: Int
    
}

// MARK: - AlbumElement

struct SearchAlbumElement: Codable {
    
    let albumType: String
    let artists: [SearchOwner]
    let availableMarkets: [String]
    let externalUrls: SearchExternalUrls
    let href: String
    let id: String
    let images: [SearchImage]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let totalTracks: Int
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type
        case uri
    }
    
}

// MARK: - Owner

struct SearchOwner: Codable {
    
    let externalUrls: SearchExternalUrls
    let href: String
    let id: String
    let name: String?
    let type: String
    let uri: String
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href
        case id
        case name
        case type
        case uri
        case displayName = "display_name"
    }
    
}

// MARK: - ExternalUrls

struct SearchExternalUrls: Codable {
    
    let spotify: String
    
}

// MARK: - Image

struct SearchImage: Codable {
    
    let height: Int?
    let url: String
    let width: Int?
    
}

// MARK: - Artists -

struct SearchArtists: Codable {
    
    let href: String
    let items: [SearchArtistsItem]
    let limit: Int
    let next: String
    let offset: Int
    let previous: Int?
    let total: Int
    
}

// MARK: - ArtistsItem

struct SearchArtistsItem: Codable {
    
    let externalUrls: SearchExternalUrls
    let followers: SearchFollowers
    let genres: [String]
    let href: String
    let id: String
    let images: [SearchImage]
    let name: String
    let popularity: Int
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case externalUrls = "external_urls"
        case followers
        case genres
        case href
        case id
        case images
        case name
        case popularity
        case type
        case uri
        
    }
    
}

// MARK: - Followers

struct SearchFollowers: Codable {
    
    let href: String?
    let total: Int
    
}

// MARK: - Playlists -

struct SearchPlaylists: Codable {
    
    let href: String
    let items: [SearchPlaylistsItem]
    let limit: Int
    let next: String
    let offset: Int
    let previous: Int?
    let total: Int
    
}

// MARK: - PlaylistsItem

struct SearchPlaylistsItem: Codable {
    
    let collaborative: Bool
    let itemDescription: String
    let externalUrls: SearchExternalUrls
    let href: String
    let id: String
    let images: [SearchImage]
    let name: String
    let owner: SearchOwner
    let primaryColor: Int?
    let itemPublic: Int?
    let snapshotID: String
    let tracks: SearchFollowers
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
        case primaryColor = "primary_color"
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
        
    }
    
}

// MARK: - Tracks -

struct SearchTracks: Codable {
    
    let href: String
    let items: [SearchTracksItem]
    let limit: Int
    let next: String
    let offset: Int
    let previous: Int?
    let total: Int
    
}

// MARK: - TracksItem

struct SearchTracksItem: Codable {
    
    let album: SearchAlbumElement
    let artists: [SearchOwner]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: SearchExternalIDS
    let externalUrls: SearchExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let popularity: Int
    let previewURL: String?
    let trackNumber: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        
        case album
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type
        case uri
        
    }
    
}

// MARK: - ExternalIDS

struct SearchExternalIDS: Codable {
    
    let isrc: String
    
}
