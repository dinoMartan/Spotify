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
        APICaller.shared.getFeaturedPlaylists { featuredPlaylistsResponse in
            // to do - handle data
        } failure: { error in
            // to do - handle error
        }
        
        // get genres and if successful, get recommendations using genres as seed
        
        APICaller.shared.getRecommendationGenres { recommendedGenresResponse in
            let genres = recommendedGenresResponse.genres
            var seeds = Set<String>()
            while seeds.count < 5 {
                guard let random = genres.randomElement() else { continue }
                seeds.insert(random)
            }
            
            APICaller.shared.getRecommendations(genres: seeds) { recommendationsResponse in
                // to do - handle data
            } failure: { error in
                // to do - handle error
            }
            
        } failure: { error in
            // to do - handle error
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
