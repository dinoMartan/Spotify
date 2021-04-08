//
//  SearchTracksCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTracksCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "SearchTracksCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(track: SearchTracksItem) {
        albumImageView.sd_setImage(with: URL(string: track.album.images.first?.url ?? ""), completed: nil)
        artistLabel.text = track.artists.first?.name
        trackNameLabel.text = track.name
    }
    
}
