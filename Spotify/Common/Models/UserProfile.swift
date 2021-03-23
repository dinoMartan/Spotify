//
//  UserProfile.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - User Profile
struct UserProfile: Codable {
    
    let country, displayName, email: String
    let externalUrls: ExternalUrls
    let followers: Followers
    let href: String
    let id: String
    let images: [Image]?
    let product, type, uri: String

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case externalUrls = "external_urls"
        case followers, href, id, images, product, type, uri
    }
    
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    
    let spotify: String
    
}

// MARK: - Followers
struct Followers: Codable {
    
    let href: Int?
    let total: Int
    
}

// MARK: - Image
struct Image: Codable {
    
    let height: Int?
    let url: String
    let width: Int?
    
}
