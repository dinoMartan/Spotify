//
//  Artist.swift
//  Spotify
//
//  Created by Dino Martan on 27/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - Artist

struct Artist: Codable {
    
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let name: String?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href
        case id
        case name
        case type
        case uri
    }
    
}
