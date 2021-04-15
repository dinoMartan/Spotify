//
//  APICallers.swift
//  Spotify
//
//  Created by Dino Martan on 05/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

extension HomeViewController {
    
    func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases: NewReleasesResponse?
        var featuredPlaylists: FeaturedPlaylistsResponse?
        var recommendations: RecommendationsResponse?
        
        // new releases
        APICaller.shared.getNewReleases(on: self) { newRelesesResponse in
            group.leave()
            newReleases = newRelesesResponse
        } failure: { _ in
            group.leave()
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchNewReleases, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        // featured playlists
        APICaller.shared.getFeaturedPlaylists(on: self) { featuresPlaylistsResponse in
            group.leave()
            featuredPlaylists = featuresPlaylistsResponse
        } failure: { _ in
            group.leave()
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchFeaturedPlaylists, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        // recommendations
        APICaller.shared.getRecommendationGenres(on: self) { recommendedGenresResponse in
            guard let seeds = self.generateGenreSeeds(genres: recommendedGenresResponse.genres) else { return }
            
            APICaller.shared.getRecommendations(on: self, genres: seeds) { recommendationsResponse in
                group.leave()
                recommendations = recommendationsResponse
            } failure: { _ in
                group.leave()
                let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchRecommendations, button: .ok)
                self.present(alert, animated: true, completion: nil)
            }
            
        } failure: { _ in
            group.leave()
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchRecommendationGenres, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items,
                  let playlists = featuredPlaylists?.playlists.items,
                  let tracks = recommendations?.tracks else {
                return
            }
            
            self.configureModels(newAlbums: newAlbums, tracks: tracks, playlists: playlists)
        }
    }
    
    private func generateGenreSeeds(genres: [String]) -> Set<String>? {
        var seeds = Set<String>()
        while seeds.count < 5 {
            guard let random = genres.randomElement() else { continue }
            seeds.insert(random)
        }
        return seeds
    }

}
