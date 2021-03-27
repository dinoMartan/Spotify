//
//  UserDefaultsExtension.swift
//  Spotify
//
//  Created by Dino Martan on 25/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

extension UserDefaults {

    static func resetDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        debugPrint(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
}
