//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Dino Martan on 27/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - Recommendations

struct Recommendations: Codable {
    
    let tracks: [Track]
    let seeds: [Seed]
    
}

// MARK: - Seed

struct Seed: Codable {
    
    let initialPoolSize: Int
    let afterFilteringSize: Int
    let afterRelinkingSize: Int
    let href: String
    let id: String
    let type: String
    
}

// MARK: - Track
struct Track: Codable {
    
    let artists: [Artist]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isPlayable: Bool
    let name: String
    let previewURL: String
    let trackNumber: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case artists
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id
        case isPlayable = "is_playable"
        case name
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
    
}
