//
//  HomeViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class HomeViewController: DMViewController {
    
    @IBAction func didTapSettingsButton(_ sender: Any) {
        let settingsViewController = UIStoryboard.instantiateViewController(name: .settings, identifier: .settings)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getFeaturedPlaylists {data in
            debugPrint(data)
        } failure: { error in
            debugPrint(error?.localizedDescription)
        }

    }
    
}

//MARK: - Actions -

extension HomeViewController {
    
    @IBAction func didPressButton(_ sender: Any) {
        let settingsViewController = UIStoryboard.instantiateViewController(name: .settings, identifier: .settings)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}
