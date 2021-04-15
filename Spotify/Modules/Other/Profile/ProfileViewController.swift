//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Dino Martan on 24/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var planLabel: UILabel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        hideElements()
        fetchProfile()
    }

}

//MARK: - Private extensions -

extension ProfileViewController {
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile(on: self) { [unowned self] userProfile in
            updateUI(with: userProfile)
        } failure: { _ in
            let alert = Alerter.getAlert(myTitle: .error, myMessage: .didntFetchUserProfile, button: .shame)
            self.dismiss(animated: true, completion: nil)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func updateUI(with userProfile: UserProfile?) {
        showElements()
        nameLabel.text = userProfile?.displayName
        planLabel.text = userProfile?.product
        loadImage(string: userProfile?.images?[0].url)
    }
    
    private func loadImage(string: String?) {
        guard let urlString = string, let url = URL(string: urlString)  else { return }
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (imageView.frame.size.width) / 2
    }
    
    private func hideElements() {
        nameLabel.isHidden = true
        imageView.isHidden = true
        planLabel.isHidden = true
    }
    
    private func showElements() {
        nameLabel.isHidden = false
        imageView.isHidden = false
        planLabel.isHidden = false
    }
    
}
