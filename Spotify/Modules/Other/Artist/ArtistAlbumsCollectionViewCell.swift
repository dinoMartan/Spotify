//
//  ArtistCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 14/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class ArtistAlbumsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var albumNameLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "ArtistAlbumsCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(album: SearchAlbumElement) {
        albumImageView.sd_setImage(with: URL(string: album.images.first?.url ?? ""), completed: nil)
        albumNameLabel.text = album.name
    }
    
}
