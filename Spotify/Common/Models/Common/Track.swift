//
//  Track.swift
//  Spotify
//
//  Created by Dino Martan on 27/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - Track

struct AudioTrack: Codable {
    
    let artists: [Artist]
    let discNumber: Int
    let durationMS: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isPlayable: Bool?
    let name: String
    let previewURL: String?
    let trackNumber: Int
    let type: String
    let uri: String

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
