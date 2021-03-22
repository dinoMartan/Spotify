//
//  AuthManager.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation
import Alamofire

final class AuthManager {
    
    //MARK: - Constants
    
    struct Constants {
        static let cliendID = "a08fd5333ea042eb85262d880d663950"
        static let clientSecret = "81b42dcb4eaa405892fe4b8e512a13fc"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let fiveMinutes: TimeInterval = 300
        static let base = "https://accounts.spotify.com/authorize"
        static let scope = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
        static let redirectURI = "https://www.iosacademy.io"
        static let headerData = "application/x-www-form-urlencoded"
        static let currentDate = Date()
    }

    //MARK: - Public properties
    
    static let shared = AuthManager()
    
    var signInURL: URL? {
        let stringUrl = "\(Constants.base)?response_type=code&client_id=\(Constants.cliendID)&scope=\(Constants.scope)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: stringUrl)
    }
    
    var isSignedIn: Bool {
        accessToken != nil
    }
    
    //MARK: - Private properties
    
    private var accessToken:String? {
        UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken:String? {
        UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        return Date().addingTimeInterval(Constants.fiveMinutes) >= expirationDate
    }
    
    private var authorization: String? {
        let basicToken = Constants.cliendID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else { return nil }
        return base64String
    }
    
    private let alamofire = AF
    
    //MARK: - Lifecycle
    
    private init() { }
    

}

//MARK: - Public extensions -

extension AuthManager {
    
    func exchangeCodeForToken(code:String, success: @escaping ((Bool) -> Void), failure: @escaping ((Error?) -> Void)) {
        guard authorization != nil else {
            failure(nil)
            return
        }
 
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic \(authorization!)"
        ]
        
        let paremeters = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": Constants.redirectURI
        ]
        
        alamofire.request(Constants.tokenAPIURL, method: .post, parameters: paremeters, headers: headers)
            .responseDecodable(of: AuthResponse.self) { [unowned self] response in
                switch(response.result) {
                    case .success(let data):
                        cacheToken(authResponse: data)
                        success(true)
                    case .failure(let errror):
                        failure(errror)
                    }
            }
    }
    
}

extension AuthManager {
    
    public func refreshIfNeeded(completion: @escaping(Bool) -> Void) {
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let refreshToken = self.refreshToken else { return }
        
        guard authorization != nil else {
            completion(false)
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic \(authorization!)"
        ]
        
        let paremeters = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        
        alamofire.request(Constants.tokenAPIURL, method: .post, parameters: paremeters, headers: headers)
            .responseDecodable(of: AuthResponse.self) { [unowned self] response in
                switch(response.result) {
                    case .success(let authResponse):
                        cacheToken(authResponse: authResponse)
                        completion(true)
                    case .failure(_):
                        completion(false)
                    }
            }
        
    }
    
}

//MARK: - Private extensions -

extension AuthManager {
    
    private func cacheToken(authResponse: AuthResponse) {
        UserDefaults.standard.setValue(authResponse.accessToken, forKey: "access_token")
        
        guard (authResponse.refreshToken != nil) else {
            UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(authResponse.expiresIn)), forKey: "expirationDate")
            return
            
        }
        UserDefaults.standard.setValue(authResponse.refreshToken, forKey: "refresh_token")
    }
    
}
