//
//  SettingsHandlers.swift
//  Spotify
//
//  Created by Dino Martan on 24/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

//MARK: - Public extensions -

extension SettingsViewController {
    
    func viewProfile() {
        let profileViewController = UIStoryboard.Storyboard.profile.viewController
        present(profileViewController, animated: true, completion: nil)
    }
    
    func signOut() {
        UserDefaults.resetDefaults()
        let welcomeViewController = UIStoryboard.Storyboard.welcome.viewController
        welcomeViewController.modalPresentationStyle = .fullScreen
        welcomeViewController.modalTransitionStyle = .flipHorizontal
        self.present(welcomeViewController, animated: true, completion: nil)
    }
    
}
