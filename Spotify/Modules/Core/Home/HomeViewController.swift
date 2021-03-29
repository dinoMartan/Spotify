//
//  HomeViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class HomeViewController: DMViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fetchData()
    }
    
}

//MARK: - Private extensions -

private extension HomeViewController {
    
    private func fetchData() {
        fetchRecommendationGenres()
        fetchNewReleases()
        fetchFeaturedPlaylists()
    }
    
}

private extension HomeViewController {
    
    private func fetchFeaturedPlaylists() {
        APICaller.shared.getFeaturedPlaylists { featuresPlaylistsResponse in
            // to do - handle data
        } failure: { _ in
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchFeaturedPlaylists, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func fetchNewReleases() {
        APICaller.shared.getNewReleases { newRelesesResponse in
            // to do - handle data
        } failure: { _ in
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchNewReleases, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // if genres are fetched, recommendations  are fetched aswell
    private func fetchRecommendationGenres() {
        APICaller.shared.getRecommendationGenres { recommendedGenresResponse in
            guard let seeds = self.generateGenreSeeds(genres: recommendedGenresResponse.genres) else { return }
            self.fetchRecommendations(seeds: seeds)
        } failure: { _ in
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchRecommendationGenres, button: .ok)
            self.present(alert, animated: true, completion: nil)
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
    
    private func fetchRecommendations(seeds: Set<String>) {
        APICaller.shared.getRecommendations(genres: seeds) { recommendationsResponse in
            // to do - handle data
        } failure: { _ in
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchRecommendations, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - Actions -

extension HomeViewController {
    
    @IBAction func didPressButton(_ sender: Any) {
        let settingsViewController = UIStoryboard.Storyboard.settings.viewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @IBAction func didTapSettingsButton(_ sender: Any) {
        let settingsViewController = UIStoryboard.Storyboard.settings.viewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}
