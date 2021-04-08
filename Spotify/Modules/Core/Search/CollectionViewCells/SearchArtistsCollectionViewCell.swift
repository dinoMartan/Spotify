//
//  SearchArtistsCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class SearchArtistsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "SearchArtistsCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(artist: SearchArtistsItem) {
        artistImageView.sd_setImage(with: URL(string: artist.images.first?.url ?? ""), completed: nil)
        artistNameLabel.text = artist.name
    }
    
}
