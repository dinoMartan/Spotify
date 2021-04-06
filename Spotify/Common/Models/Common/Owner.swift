//
//  Owner.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - Owner

struct Owner: Codable {
    
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        
        case externalUrls = "external_urls"
        case href
        case id
        case type
        case uri
        
    }
    
}
