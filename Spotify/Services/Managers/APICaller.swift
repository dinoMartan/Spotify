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
        alamofire.request(APIUrl.currentUsersProfile + "/me", method: .get, headers: headers)
            .responseDecodable(of: UserProfile.self) { response in
                switch(response.result) {
                case .success(let userProfile):
                    success(userProfile)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func testingData(success: @escaping () -> Void) {
        alamofire.request(APIUrl.currentUsersProfile + "/me", method: .get, headers: headers)
            .response { response in
                debugPrint(response)
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
