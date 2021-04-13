//
//  LibraryTableViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 10/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

protocol LibraryTableViewCellDelegate: AnyObject {
    
    func didTapDeletePlaylistButton(playlist: PlaylistItem)
    
}

class LibraryTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet private weak var playlistImageView: UIImageView!
    @IBOutlet private weak var playlistName: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "LibraryTableViewCell"
    weak var delegate: LibraryTableViewCellDelegate?
    
    //MARK: - Private properties
    
    private var playlist: PlaylistItem?
    
    //MARK: - Lifecycle
    
    func configureCell(playlist: PlaylistItem) {
        self.playlist = playlist
        if let playlistItem = playlist.images.first?.url, playlistItem != "" {
            playlistImageView.sd_setImage(with: URL(string: playlistItem), completed: nil)
        }
        playlistName.text = playlist.name
    }
    
}

//MARK: - IBActions

extension LibraryTableViewCell {
    
    @IBAction func didTapDeletePlaylistButton(_ sender: Any) {
        guard let playlist = playlist else { return }
        delegate?.didTapDeletePlaylistButton(playlist: playlist)
    }
    
}
