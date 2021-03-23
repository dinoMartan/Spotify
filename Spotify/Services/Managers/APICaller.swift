//
//  APICaller.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

final class APICaller {
    
    //MARK: - Public properties
    
    static let shared = APICaller()
    
    //MARK: - Private properties
    
    //MARK: - Lifecycle
    
    private init() { }
    
    func currentUserProfile(success: @escaping (UserProfile) -> Void, failure: @escaping (Error) -> Void) {
        AuthManager.shared.getValidToken { token in
            <#code#>
        } failure: {
            // did not get valid token
        }

    }
    
}
