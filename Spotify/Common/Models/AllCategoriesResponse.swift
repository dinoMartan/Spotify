//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

// MARK: - AllCategoriesResponse

struct AllCategoriesResponse: Codable {
    
    let response: Categories
    
    enum CodingKeys: String, CodingKey {
        
        case response = "categories"
        
    }
    
}

// MARK: - Categories

struct Categories: Codable {
    
    let href: String
    let categories: [Category]
    let limit: Int
    let next: String
    let offset: Int
    let previous: Int?
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case href
        case categories = "items"
        case limit
        case next
        case offset
        case previous
        case total
    }
    
}

// MARK: - Category

struct Category: Codable {
    
    let href: String
    let icons: [CategoryIcon]?
    let id: String
    let name: String
    
}

// MARK: - CategoryIcon

struct CategoryIcon: Codable {
    
    let height: Int?
    let url: String?
    let width: Int?
    
}
