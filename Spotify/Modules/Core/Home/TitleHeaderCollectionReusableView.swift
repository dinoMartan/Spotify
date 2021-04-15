//
//  TitleHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "TitleHeaderCollectionReusableView"
    
    //MARK: - Lifecycle
    
    func configureHeader(title: String) {
        titleLabel.text = title
    }
        
}
