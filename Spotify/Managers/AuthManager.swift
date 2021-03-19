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
    
    public var signInURL: URL?{
        let base = "https://accounts.spotify.com/authorize"
        let scope = "user-read-private"
        let redirectURI = "https://www.iosacademy.io"
        let stringUrl = "\(base)?response_type=code&client_id=\(Constants.cliendID)&scope=\(scope)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        
        return URL(string: stringUrl)
    }
    
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
    
    public func exchangeCodeForToken(code:String, completion: @escaping ((Bool) -> Void)){
        
    }
    
    private func cacheToken(){
        
    }
    
    private func refreshAccessToken(){
        
    }
}
