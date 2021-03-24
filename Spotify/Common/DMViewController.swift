//
//  DMViewController.swift
//  Spotify
//
//  Created by Dino Martan on 20/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class DMViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
