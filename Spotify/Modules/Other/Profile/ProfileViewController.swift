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
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var plan: UILabel!
    
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
        APICaller.shared.currentUserProfile { [unowned self] userProfile in
            DispatchQueue.main.async { updateUI(with: userProfile) }
        } failure: { _ in
            let alert = Alerter.getAlert(myTitle: .error, myMessage: .didntFetchUserProfile, button: .shame)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func updateUI(with userProfile: UserProfile?) {
        showElements()
        name.text = userProfile?.displayName
        plan.text = userProfile?.product
        loadImage(string: userProfile?.images?[0].url)
    }
    
    private func loadImage(string: String?) {
        guard let urlString = string, let url = URL(string: urlString)  else { return }
        image.sd_setImage(with: url, completed: nil)
        image.layer.masksToBounds = true
        image.layer.cornerRadius = (image.frame.size.width)/2
    }
    
    private func hideElements() {
        name.isHidden = true
        image.isHidden = true
        plan.isHidden = true
    }
    
    private func showElements() {
        name.isHidden = false
        image.isHidden = false
        plan.isHidden = false
    }
    
}
