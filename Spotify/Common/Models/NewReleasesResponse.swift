//
//  NewReleases.swift
//  Spotify
//
//  Created by Dino Martan on 27/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - Welcome

struct NewReleasesResponse: Codable {
    
    let albums: Albums
    
}

// MARK: - Albums

struct Albums: Codable {
    
    let href: String
    let items: [NewReleasesItem]
    let limit: Int
    let next: String
    let offset: Int
    let previous: Int?
    let total: Int
    
}

// MARK: - Item

struct NewReleasesItem: Codable {
    
    let albumType: String?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [APIImage]?
    let name: String?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
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
