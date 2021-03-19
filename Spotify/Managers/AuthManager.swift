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
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
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
        return accessToken != nil
    }
    
    private var accessToken:String?{
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken:String?{
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date?{
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshBool: Bool{
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
        
    }
    
    public func exchangeCodeForToken(code:String, completion: @escaping ((Bool) -> Void)){
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
        
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
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self ]data, _, error in
            guard let data = data,
                  error == nil else{
                completion(false)
                return
            }
            
            do{
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                let json = try JSONSerialization.jsonObject(with: data,
                                                        options: .allowFragments)
                print("SUCCESS")
                print(json)
                completion(true)
            }catch{
                completion(false)
            }
        }
        task.resume()
    }
    
    private func cacheToken(result: AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        UserDefaults.standard.setValue(result.refresh_token, forKey: "refresh_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
    
    private func refreshAccessToken(){
        
    }
}
