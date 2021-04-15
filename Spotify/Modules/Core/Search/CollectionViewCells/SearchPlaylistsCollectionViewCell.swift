//
//  SearchPlaylistsCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class SearchPlaylistsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var playlistImageView: UIImageView!
    @IBOutlet private weak var playlistNameLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "SearchPlaylistsCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(playlist: SearchPlaylistsItem) {
        playlistImageView.sd_setImage(with: URL(string: playlist.images.first?.url ?? ""), completed: nil)
        playlistNameLabel.text = playlist.name
    }
    
}
