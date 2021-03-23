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

        
        //let vcTest = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "home")
        //navigationController?.pushViewController(vcTest, animated: true)
    }
    
}
