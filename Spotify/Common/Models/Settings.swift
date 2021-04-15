//
//  Settings.swift
//  Spotify
//
//  Created by Dino Martan on 24/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

struct Section {
    
    let title: String
    let settings: [Setting]
    
}

struct Setting {
    
    let title: String
    let handler: () -> Void
    
}
