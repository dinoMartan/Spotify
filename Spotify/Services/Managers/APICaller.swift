//
//  APICaller.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation
import Alamofire

final class APICaller {
        
    //MARK: - Public properties
    
    static let shared = APICaller()
    
    //MARK: - Private properties
    
    private let alamofire = AF
    private var headers: HTTPHeaders? {
        guard let _ = AuthManager.shared.accessToken else { return nil }
        return ["Authorization": "Bearer \(AuthManager.shared.accessToken!)"]
    }
    
    //MARK: - Lifecycle
    
    private init() { }
     
    func currentUserProfile(success: @escaping (UserProfile?) -> Void, failure: @escaping (Error?) -> Void) {
        alamofire.request(APIConstants.currentUserProfileUrl, method: .get, headers: headers)
            .responseDecodable(of: UserProfile.self) { response in
                switch(response.result) {
                case .success(let userProfile):
                    success(userProfile)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func getNewReleases(success: @escaping (NewReleasesResponse) -> Void, failure: @escaping (Error?) -> Void) {
        alamofire.request(APIConstants.newReleasesUrl, method: .get, parameters: APIParameters.newReleases, headers: headers)
            .responseDecodable(of: NewReleasesResponse.self) { response in
                switch(response.result) {
                case .success(let newRelease):
                    success(newRelease)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func getFeaturedPlaylists(success: @escaping (FeaturedPlaylistsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        alamofire.request(APIConstants.featuredPlaylistsUrl, method: .get, parameters: APIParameters.newReleases, headers: headers)
            .responseDecodable(of: FeaturedPlaylistsResponse.self) { response in
                switch(response.result) {
                case .success(let featuredPlaylists):
                    success(featuredPlaylists)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func getRecommendations(success: @escaping (FeaturedPlaylistsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        alamofire.request(APIConstants.featuredPlaylistsUrl, method: .get, parameters: APIParameters.newReleases, headers: headers)
            .responseDecodable(of: FeaturedPlaylistsResponse.self) { response in
                switch(response.result) {
                case .success(let featuredPlaylists):
                    success(featuredPlaylists)
                case .failure(let error):
                    failure(error)
                }
            }
    }

}

//MARK: - Private extensions -

extension APICaller {
    
    private func getHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(AuthManager.shared.accessToken!)"
        ]
        return headers
    }

}
