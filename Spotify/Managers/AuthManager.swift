//
//  AuthManager.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    
    struct Constants{
        static let cliendID = "a08fd5333ea042eb85262d880d663950"
        static let clientSecret = "81b42dcb4eaa405892fe4b8e512a13fc"
    }
    
    private init(){}
    
    var isSignedIn: Bool{
        return false
    }
    
    private var accessToken:String?{
        return nil
    }
    
    private var refreshToken:String?{
        return nil
    }
    
    private var tokenExpirationDate: Date?{
        return nil
    }
    
    private var shouldRefreshBool: Bool{
        return false
        
    }
}
