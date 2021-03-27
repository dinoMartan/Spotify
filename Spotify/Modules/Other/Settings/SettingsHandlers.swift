//
//  SettingsHandlers.swift
//  Spotify
//
//  Created by Dino Martan on 24/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

extension SettingsViewController {
    
    func viewProfile() {
        let profileViewController = UIStoryboard.instantiateViewController(name: .profile, identifier: .profile)
        present(profileViewController, animated: true, completion: nil)
    }
    
    func signOut() {
        UserDefaults.resetDefaults()
        let welcomeViewController = UIStoryboard.instantiateViewController(name: .welcome, identifier: .welcome)
        welcomeViewController.modalPresentationStyle = .fullScreen
        welcomeViewController.modalTransitionStyle = .flipHorizontal
        self.present(welcomeViewController, animated: true, completion: nil)
    }
    
}
