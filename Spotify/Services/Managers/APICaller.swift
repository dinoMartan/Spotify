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
        let token = AuthManager.shared.accessToken
        return ["Authorization": "Bearer \(token ?? "")"]
    }
    
    //MARK: - Lifecycle
    
    private init() { }
    
    //MARK: - Profile
     
    func getCurrentUserProfile(success: @escaping (UserProfile?) -> Void, failure: @escaping (Error?) -> Void) {
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
    
    //MARK: - Albums
    
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
    
    func getAlbumDetails(for album: NewReleasesItem, success: @escaping (AlbumDetailsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        let url = APIConstants.albumDetailsUrl + (album.id ?? "")
        alamofire.request(url, method: .get, headers: headers)
            .responseDecodable(of: AlbumDetailsResponse.self) { response in
                switch(response.result) {
                case .success(let albumDetailsResponse):
                    success(albumDetailsResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Playlists
    
    func getFeaturedPlaylists(success: @escaping (FeaturedPlaylistsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        alamofire.request(APIConstants.featuredPlaylistsUrl, method: .get, parameters: APIParameters.featuredPlaylists, headers: headers)
            .responseDecodable(of: FeaturedPlaylistsResponse.self) { response in
                switch(response.result) {
                case .success(let featuredPlaylists):
                    success(featuredPlaylists)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func getPlaylist(for playlist: PlaylistItem, success: @escaping (PlaylistResponse) -> Void, failure: @escaping (Error?) -> Void) {
        let url = APIConstants.playlistUrl + playlist.id
        alamofire.request(url, method: .get, headers: headers)
            .responseDecodable(of: PlaylistResponse.self) { response in
                switch(response.result) {
                case .success(let playlistResponse):
                    success(playlistResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Genres
    
    func getRecommendationGenres(success: @escaping (RecommendationGenresResponse) -> Void, failure: @escaping (Error?) -> Void) {
        alamofire.request(APIConstants.recommendationGenresUrl, method: .get, parameters: APIParameters.featuredPlaylists, headers: headers)
            .responseDecodable(of: RecommendationGenresResponse.self) { response in
                switch(response.result) {
                case .success(let recommendationGenresResponse):
                    success(recommendationGenresResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Category
    
    func getAllCategories(success: @escaping (AllCategoriesResponse) -> Void, failure: @escaping (Error?) -> Void) {
        alamofire.request(APIConstants.allCagetoriesUrl, method: .get, parameters: APIParameters.allCategories, headers: headers)
            .responseDecodable(of: AllCategoriesResponse.self) { response in
                switch(response.result) {
                case .success(let allCategoriesResponse):
                    success(allCategoriesResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func getCategoryPlaylists(for category: Category, success: @escaping (CategoryPlaylistsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        let url = APIConstants.categoryPlaylistsUrl + category.id + "/playlists"
        alamofire.request(url, method: .get, headers: headers)
            .responseDecodable(of: CategoryPlaylistsResponse.self) { response in
                switch(response.result) {
                case .success(let categoryPlaylists):
                    success(categoryPlaylists)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Tracks
    
    func getRecommendations(genres: Set<String>, success: @escaping (RecommendationsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        
        let seeds = genres.joined(separator: ",")
        let url = "\(APIConstants.recommendationsUrl)?seed_genres=\(seeds)"
        
        alamofire.request(url, method: .get, headers: headers)
            .responseDecodable(of: RecommendationsResponse.self) { response in
                switch(response.result) {
                case .success(let recommendationsRespond):
                    success(recommendationsRespond)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Search
    
    func search(with query: String, success: @escaping (SearchResponse) -> Void, failure: @escaping (Error?) -> Void) {
        let url = APIConstants.searchUrl + "?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&type=album,artist,playlist,track&limit=25"
        alamofire.request(url, method: .get, parameters: APIParameters.allCategories, headers: headers)
            .responseDecodable(of: SearchResponse.self) { response in
                switch(response.result) {
                case .success(let searchResponse):
                    success(searchResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }

}
