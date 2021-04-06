//
//  AlbumCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!

    //MARK: - Public properties
    
    static let identifier = "AlbumCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(audioTrack: AudioTrack) {
        artistNameLabel.text = audioTrack.artists.first?.name
        trackNameLabel.text = audioTrack.name
    }
    
}
