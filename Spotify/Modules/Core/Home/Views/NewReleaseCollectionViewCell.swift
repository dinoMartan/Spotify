//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 05/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var albumCoverImage: UIImageView!
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "NewReleaseCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(with model: NewRelesesCellViewModel) {
        albumCoverImage.sd_setImage(with: model.artworkUrl, completed: nil)
        albumNameLabel.text = model.name
        artistNameLabel.text = model.artistName
    }

}
