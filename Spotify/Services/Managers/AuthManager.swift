//
//  AuthManager.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

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
    
    //MARK: - IBOutlets

    //MARK: - Public properties
    
    static let shared = AuthManager()
    
    var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let scope = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
        let redirectURI = "https://www.iosacademy.io"
        let stringUrl = "\(base)?response_type=code&client_id=\(Constants.cliendID)&scope=\(scope)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        
        return URL(string: stringUrl)
    }
    
    var isSignedIn: Bool {
        accessToken != nil
    }
    
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
    
    //MARK: - Lifecycle
    
    private init() { }
    
    func exchangeCodeForToken(code:String, success: @escaping ((Bool) -> Void), failure: @escaping ((Error?) -> Void)) {
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.iosacademy.io")
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = Constants.cliendID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            failure(nil)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [unowned self] data, _, error in
            guard let data = data,
                  error == nil else {
                failure(error)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                cacheToken(result: result)
                success(true)
            } catch{
                failure(error)
            }
        }
        task.resume()
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken, forKey: "access_token")
        
        guard (result.refreshToken != nil) else {
            UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expirationDate")
            return
            
        }
        UserDefaults.standard.setValue(result.refreshToken, forKey: "refresh_token")
    }
    
    public func refreshIfNeeded(completion: @escaping(Bool) -> Void) {
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let refreshToken = self.refreshToken else { return }
        
        // Refreshing token
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = Constants.cliendID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [unowned self ]data, _, error in
            guard let data = data,
                  error == nil else{
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                cacheToken(result: result)
                completion(true)
            } catch {
                completion(false)
            }
        }
        task.resume()
    }
    
}