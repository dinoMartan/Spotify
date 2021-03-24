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
        let settingsViewController = UIViewController.MyViewControllers.settingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupView() {
        let settingsViewController = UIViewController.MyViewControllers.settingsViewController
        navigationController?.setViewControllers([settingsViewController], animated: true)
    }
    
}

//MARK: - Actions -

extension HomeViewController {
    
    @IBAction func didPressButton(_ sender: Any) {
        APICaller.shared.currentUserProfile { _ in
            //
        } failure: { _ in
            //
        }
        let settingsViewController = UIViewController.MyViewControllers.settingsViewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}
