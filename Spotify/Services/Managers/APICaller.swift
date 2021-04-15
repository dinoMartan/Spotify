//
//  APICaller.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation
import Alamofire

protocol APICallerDelegate: AnyObject {
    
    func isNotSignedIn()
    
}

final class APICaller {
        
    //MARK: - Public properties
    
    static let shared = APICaller()
    weak var delegate: APICallerDelegate? // if used, app crashes
    
    //MARK: - Private properties
    
    private let alamofire = AF
    private var headers: HTTPHeaders? {
        let token = AuthManager.shared.accessToken
        return ["Authorization": "Bearer \(token ?? "")"]
    }
    
    private var headersContentType: HTTPHeaders? {
        let token = AuthManager.shared.accessToken
        return [
            "Authorization": "Bearer \(token ?? "")",
            "Content-Type": "application/json"
        ]
    }
    
    //MARK: - Lifecycle
    
    private init() { }
    
    private func checkIfSignedIn(on viewController: UIViewController) {
        let userSignedIn = AuthManager.shared.isSignedIn
        if !userSignedIn {
            let alert = UIAlertController(title: AlertsConstants.Titles.sessionExpired.rawValue, message: AlertsConstants.Messages.sessionExpired.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: AlertsConstants.Button.ok.rawValue, style: .default, handler: { _ in
                self.delegate?.isNotSignedIn()
            }))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Artists
    
    func getArtistsAlbums(on viewController: UIViewController, for artistId: String, success: @escaping (SearchAlbums) -> Void, failure: @escaping (Error) -> Void) {
        checkIfSignedIn(on: viewController)
        let url = APIConstants.artistsUrl + "/\(artistId)/albums"
        alamofire.request(url, method: .get, headers: headers)
            .responseDecodable(of: SearchAlbums.self) { response in
                switch(response.result) {
                case .success(let albums):
                    success(albums)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func getArtistsTopTracks(on viewController: UIViewController, for artistId: String, success: @escaping (ArtistsTracksResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
        // get user profile for user region
        getCurrentUserProfile(on: viewController) { [unowned self] userProfile in
            let parameter = ["market": userProfile?.country]
            let url = APIConstants.artistsUrl + "/\(artistId)/top-tracks"
            alamofire.request(url, method: .get, parameters: parameter, headers: headers)
                .responseDecodable(of: ArtistsTracksResponse.self) { response in
                    switch(response.result) {
                    case .success(let tracks):
                        success(tracks)
                    case .failure(let error):
                        failure(error)
                    }
                }
        } failure: { error in
            failure(error)
        }
    }
    
    //MARK: - Profile
     
    func getCurrentUserProfile(on viewController: UIViewController, success: @escaping (UserProfile?) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
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
    
    func getNewReleases(on viewController: UIViewController, success: @escaping (NewReleasesResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
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
    
    func getAlbumDetails(on viewController: UIViewController, for album: NewReleasesItem, success: @escaping (AlbumDetailsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
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
    
    func getFeaturedPlaylists(on viewController: UIViewController, success: @escaping (FeaturedPlaylistsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
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
    
    func getPlaylistDetails(on viewController: UIViewController, for playlist: PlaylistItem, success: @escaping (PlaylistResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
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
    
    func getCurrentUserPlaylists(on viewController: UIViewController, success: @escaping (Playlists) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
        alamofire.request(APIConstants.currentUserPlaylists, method: .get, headers: headers)
            .responseDecodable(of: Playlists.self) { response in
                switch(response.result) {
                case .success(let playlistResponse):
                    success(playlistResponse)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func createUserPlaylist(on viewController: UIViewController, name: String, success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
        // user ID is needed, first get user profile
        getCurrentUserProfile(on: viewController) { [unowned self] userProfile in
            // isolating user ID
            guard let userId = userProfile?.id else {
                failure(nil)
                return
            }
            
            let url = APIConstants.createPlaylistUrl + userId + "/playlists"
            let parameters: [String: AnyObject] = ["name": name as AnyObject]
            
            alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch(response.result) {
                    case .success(_):
                        success()
                    case .failure(let error):
                        failure(error)
                    }
                }
        } failure: { error in
            failure(error)
        }
    }
    
    func addTrackToPlaylist(on viewController: UIViewController, playlistId: String, trackUri: String, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        checkIfSignedIn(on: viewController)
        let url = APIConstants.playlistUrl + "\(playlistId)/tracks"
        let parameters = ["uris": [trackUri]]
        alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headersContentType)
            .responseJSON { response in
                switch(response.result) {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func deleteTrackFromPlaylist(on viewController: UIViewController, playlistId: String, trackUri: String, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        checkIfSignedIn(on: viewController)
        let url = APIConstants.playlistUrl + "\(playlistId)/tracks"
        let parameters = ["uris": [trackUri]]
        alamofire.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headersContentType)
            .responseJSON { response in
                switch(response.result) {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func deleteUsersPlaylist(on viewController: UIViewController, playlistId: String, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        checkIfSignedIn(on: viewController)
        let url = APIConstants.playlistUrl + "\(playlistId)/followers"
        alamofire.request(url, method: .delete, headers: headers)
            .response { response in
                switch(response.result) {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    //MARK: - Genres
    
    func getRecommendationGenres(on viewController: UIViewController, success: @escaping (RecommendationGenresResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
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
    
    func getAllCategories(on viewController: UIViewController, success: @escaping (AllCategoriesResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
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
    
    func getCategoryPlaylists(on viewController: UIViewController, for category: Category, success: @escaping (CategoryPlaylistsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
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
    
    func getRecommendations(on viewController: UIViewController, genres: Set<String>, success: @escaping (RecommendationsResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
        
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
    
    func search(on viewController: UIViewController, with query: String, success: @escaping (SearchResponse) -> Void, failure: @escaping (Error?) -> Void) {
        checkIfSignedIn(on: viewController)
        let url = APIConstants.searchUrl + "?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&type=album,artist,playlist,track&limit=12"
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
