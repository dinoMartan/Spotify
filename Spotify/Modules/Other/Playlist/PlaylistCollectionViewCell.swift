//
//  PlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackAlbumNameLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    
    
    //MARK: - Public properties
    
    static let identifier = "PlaylistCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(playlistTrackItem: PlaylistTrackItem) {
        trackImageView.sd_setImage(with: URL(string: playlistTrackItem.track.album.images.first?.url ?? ""), completed: nil)
        trackAlbumNameLabel.text = playlistTrackItem.track.album.name
        trackNameLabel.text = playlistTrackItem.track.name
    }
    
    
    
}
