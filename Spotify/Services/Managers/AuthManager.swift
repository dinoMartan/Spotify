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
    
    //MARK: - Typealiases
    
    typealias closureBool = ((Bool) -> Void)
    typealias closureString = ((String) -> Void)
    typealias closureError = ((Error?) -> Void)
    typealias closureVoid = (() -> Void)
    
    
    //MARK: - Public properties
    
    static let shared = AuthManager()
    
    var signInURL: URL? {
        let stringUrl = "\(AuthenticationConstants.base)?response_type=code&client_id=\(AuthenticationConstants.cliendID)&scope=\(AuthenticationConstants.scope)&redirect_uri=\(AuthenticationConstants.redirectURI)&show_dialog=TRUE"
        return URL(string: stringUrl)
    }
    
    var isSignedIn: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        return Date() <= expirationDate
    }
    
    var authorization: String? {
        let basicToken = AuthenticationConstants.cliendID + ":" + AuthenticationConstants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else { return nil }
        return base64String
    }
    
    //MARK: - Private properties
    
    var accessToken:String? {
        userDefaults.string(forKey: AuthenticationConstants.Keys.accessToken)
    }
    
    private var refreshToken:String? {
        userDefaults.string(forKey: AuthenticationConstants.Keys.refreshToken)
    }
    
    var tokenExpirationDate: Date? {
        userDefaults.object(forKey: AuthenticationConstants.Keys.expirationDate) as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        return Date().addingTimeInterval(AuthenticationConstants.fiveMinutes) >= expirationDate
    }
    
    private let alamofire = AF
    
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
}

//MARK: - Public extensions -

extension AuthManager {
    
    func exchangeCodeForToken(code:String, success: @escaping closureBool, failure: @escaping closureError) {
        guard let auth = authorization else {
            failure(nil)
            return
        }
 
        let headers: HTTPHeaders = [
            AuthenticationConstants.Keys.contentType: AuthenticationConstants.Keys.urlEncoded,
            AuthenticationConstants.Keys.authorization: "Basic \(auth)"
        ]
        
        let parameters = [
            AuthenticationConstants.Keys.grantType: AuthenticationConstants.Keys.authorizationCode,
            AuthenticationConstants.Keys.code: code,
            AuthenticationConstants.Keys.redirectUri: AuthenticationConstants.redirectURI
        ]
        
        alamofire.request(AuthenticationConstants.tokenAPIURL, method: .post, parameters: parameters, headers: headers)
            .responseDecodable(of: AuthResponse.self) { [unowned self] response in
                switch(response.result) {
                    case .success(let data):
                        cacheToken(authResponse: data)
                        success(true)
                    case .failure(let error):
                        failure(error)
                    }
            }
    }
    
}

extension AuthManager {
    
    func getValidToken(success: @escaping closureString, failure: @escaping closureVoid) {
        refreshIfNeeded { completion in
            guard completion, let token = self.accessToken else {
                failure()
                return
            }
            success(token)
        }
    }
    
    func refreshIfNeeded(completion: @escaping closureBool) {
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let refreshToken = refreshToken else { return }
        
        guard authorization != nil else {
            completion(false)
            return
        }
        
        let headers: HTTPHeaders = [
            AuthenticationConstants.Keys.contentType: AuthenticationConstants.Keys.urlEncoded,
            AuthenticationConstants.Keys.authorization: "Basic \(authorization!)"
        ]
        
        let paremeters = [
            AuthenticationConstants.Keys.grantType: AuthenticationConstants.Keys.refreshToken,
            AuthenticationConstants.Keys.refreshToken: refreshToken
        ]
        
        alamofire.request(AuthenticationConstants.tokenAPIURL, method: .post, parameters: paremeters, headers: headers)
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
        userDefaults.setValue(authResponse.accessToken, forKey: AuthenticationConstants.Keys.accessToken)
        let expirationDate = Date().addingTimeInterval(TimeInterval(authResponse.expiresIn))
        userDefaults.setValue(expirationDate, forKey: AuthenticationConstants.Keys.expirationDate)
        guard (authResponse.refreshToken != nil) else { return }
        userDefaults.setValue(authResponse.refreshToken, forKey: AuthenticationConstants.Keys.refreshToken)
    }
    
}
