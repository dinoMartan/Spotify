//
//  ArtistsTracksResponse.swift
//  Spotify
//
//  Created by Dino Martan on 15/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - ArtistsTracksResponse
struct ArtistsTracksResponse: Codable {
    
    let tracks: [ArtistsTrack]
    
}

// MARK: - Track
struct ArtistsTrack: Codable {
    
    let album: ArtistsAlbum
    let artists: [Artist]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let isPlayable: Bool
    let name: String
    let popularity: Int
    let previewURL: String?
    let trackNumber: Int
    let type: TrackType
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case album, artists
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href
        case id
        case isLocal = "is_local"
        case isPlayable = "is_playable"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type
        case uri
        
    }
    
    // MARK: - ExternalIDS
    
    struct ExternalIDS: Codable {
        
        let isrc: String
        
    }
    
}

// MARK: - Album

struct ArtistsAlbum: Codable {
    
    let albumType: AlbumTypeEnum
    let artists: [Artist]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [APIImage]
    let name, releaseDate: String
    let releaseDatePrecision: ReleaseDatePrecision
    let totalTracks: Int
    let type: AlbumTypeEnum
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case albumType = "album_type"
        case artists
        case externalUrls = "external_urls"
        case href
        case id
        case images
        case name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type
        case uri
        
    }
    
}

enum AlbumTypeEnum: String, Codable {
    
    case album = "album"
    case single = "single"
    
}

enum ReleaseDatePrecision: String, Codable {
    
    case day = "day"
    
}

enum TrackType: String, Codable {
    
    case track = "track"
    
}
