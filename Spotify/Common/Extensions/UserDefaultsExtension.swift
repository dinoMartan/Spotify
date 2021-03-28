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
        guard let domain = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        debugPrint(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
}
