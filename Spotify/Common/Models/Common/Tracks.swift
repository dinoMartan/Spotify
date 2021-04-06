//
//  Tracks.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - Tracks

struct Tracks: Codable {
    
    let href: String
    let audioTracks: [AudioTrack]
    let limit: Int
    let next: Int?
    let offset: Int
    let previous: Int?
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        
        case href
        case audioTracks = "items"
        case limit
        case next
        case offset
        case previous
        case total
        
    }
    
}
