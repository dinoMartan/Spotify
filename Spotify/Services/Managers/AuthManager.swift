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
        
        struct Keyes {
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

    //MARK: - Public properties
    
    static let shared = AuthManager()
    
    var signInURL: URL? {
        let stringUrl = "\(Constants.base)?response_type=code&client_id=\(Constants.cliendID)&scope=\(Constants.scope)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: stringUrl)
    }
    
    var isSignedIn: Bool {
        accessToken != nil
    }
    
    var authorization: String? {
        let basicToken = Constants.cliendID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else { return nil }
        return base64String
    }
    
    //MARK: - Private properties
    
    private var refreshingToken = false
    private var onRefreshBlocks = [((String) -> Void)]()
    
    var accessToken:String? {
        UserDefaults.standard.string(forKey: Constants.Keyes.accessToken)
    }
    
    private var refreshToken:String? {
        UserDefaults.standard.string(forKey: Constants.Keyes.refreshToken)
    }
    
    private var tokenExpirationDate: Date? {
        UserDefaults.standard.object(forKey: Constants.Keyes.expirationDate) as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        return Date().addingTimeInterval(Constants.fiveMinutes) >= expirationDate
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
            Constants.Keyes.contentType: Constants.Keyes.urlEncoded,
            Constants.Keyes.authorization: "Basic \(authorization!)"
        ]
        
        let paremeters = [
            Constants.Keyes.grantType: Constants.Keyes.authorizationCode,
            Constants.Keyes.code: code,
            Constants.Keyes.redirectUri: Constants.redirectURI
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
    
    func getValidToken(success: @escaping (String) -> Void, failure: @escaping () -> Void) {
        refreshIfNeeded { completion in
            guard !completion else {
                failure()
                return
            }
            success(self.accessToken!)
        }
    }
    
    func refreshIfNeeded(completion: @escaping(Bool) -> Void) {
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
            Constants.Keyes.contentType: Constants.Keyes.urlEncoded,
            Constants.Keyes.authorization: "Basic \(authorization!)"
        ]
        
        let paremeters = [
            Constants.Keyes.grantType: Constants.Keyes.refreshToken,
            Constants.Keyes.refreshToken: refreshToken
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
        UserDefaults.standard.setValue(authResponse.accessToken, forKey: Constants.Keyes.accessToken)
        guard (authResponse.refreshToken != nil) else {
            UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(authResponse.expiresIn)), forKey: Constants.Keyes.expirationDate)
            return
        }
        UserDefaults.standard.setValue(authResponse.refreshToken, forKey: Constants.Keyes.refreshToken)
    }
    
}
