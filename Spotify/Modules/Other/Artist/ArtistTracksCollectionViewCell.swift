//
//  ArtistPlaylistsCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 14/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class ArtistTracksCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "ArtistTracksCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(track: ArtistsTrack) {
        trackImageView.sd_setImage(with: URL(string: track.album.images.first?.url ?? ""), completed: nil)
        trackNameLabel.text = track.name
    }
    
}
