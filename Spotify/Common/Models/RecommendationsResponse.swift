//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Dino Martan on 27/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - Recommendations

struct RecommendationsResponse: Codable {
    
    let tracks: [AudioTrack]
    let seeds: [Seed]
    
}

// MARK: - Seed

struct Seed: Codable {
    
    let initialPoolSize: Int
    let afterFilteringSize: Int
    let afterRelinkingSize: Int
    let href: String?
    let id: String
    let type: String
    
}
