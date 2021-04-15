//
//  AuthenticationConstants.swift
//  Spotify
//
//  Created by Dino Martan on 23/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

enum AuthenticationConstants {
    
    static let cliendID = "a08fd5333ea042eb85262d880d663950"
    static let clientSecret = "81b42dcb4eaa405892fe4b8e512a13fc"
    static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    static let fiveMinutes: TimeInterval = 300
    static let base = "https://accounts.spotify.com/authorize"
    static let scope = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    static let redirectURI = "https://www.iosacademy.io"
    static let headerData = "application/x-www-form-urlencoded"
    static let currentDate = Date()
    
    enum Keys {
        
        static let accessToken = "access_token"
        static let refreshToken = "refresh_token"
        static let expirationDate = "expirationDate"
        static let contentType = "Content-Type"
        static let urlEncoded = "application/x-www-form-urlencoded"
        static let authorization = "Authorization"
        static let grantType = "grant_type"
        static let code = "code"
        static let authorizationCode = "authorization_code"
        static let redirectUri = "redirect_uri"
        
    }
    
}
