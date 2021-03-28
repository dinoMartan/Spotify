//
//  DMViewController.swift
//  Spotify
//
//  Created by Dino Martan on 20/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class DMViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupNavigationController()
    }
    
}

//MARK: - Private extensions -

private extension DMViewController {
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
