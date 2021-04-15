//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - AlbumDetailsResponse

struct AlbumDetailsResponse: Codable {
    
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]
    let copyrights: [Copyright]
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let genres: [String]
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let popularity: Int
    let releaseDate: String
    let releaseDatePrecision: String
    let tracks: Tracks
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case copyrights
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case genres
        case href
        case id
        case images
        case name
        case popularity
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case tracks
        case type
        case uri
        
    }
    
}
