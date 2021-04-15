//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 05/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var playlistCoverImageView: UIImageView!
    @IBOutlet private weak var playlistNameLable: UILabel!
    @IBOutlet private weak var typeLable: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(data: FeaturedPlaylistsCellViewModel) {
        playlistNameLable.text = data.name
        typeLable.text = data.type
        playlistCoverImageView.sd_setImage(with: data.artworkURL, completed: nil)
    }
    
    
}
