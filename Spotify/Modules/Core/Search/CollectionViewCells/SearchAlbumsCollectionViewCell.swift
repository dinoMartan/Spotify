//
//  SearchAlbumsCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class SearchAlbumsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet private weak var albumArtistLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "SearchAlbumsCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(album: SearchAlbumElement) {
        albumImageView.sd_setImage(with: URL(string: album.images.first?.url ?? ""), completed: nil)
        albumNameLabel.text = album.name
        albumArtistLabel.text = album.artists.first?.name
    }
    
}
