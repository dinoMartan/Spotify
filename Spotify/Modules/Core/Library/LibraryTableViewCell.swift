//
//  LibraryTableViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 10/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class LibraryTableViewDataCell: UITableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet private weak var playlistImageView: UIImageView!
    @IBOutlet private weak var playlistName: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "LibraryTableViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(playlist: PlaylistItem) {
        if let playlistItem = playlist.images.first?.url, playlistItem != "" {
            playlistImageView.sd_setImage(with: URL(string: playlistItem), completed: nil)
        }
        playlistName.text = playlist.name
    }

}
