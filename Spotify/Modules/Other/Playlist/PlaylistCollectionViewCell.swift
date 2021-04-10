//
//  PlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

protocol PlaylistCollectionViewCellDelegate: AnyObject {
    
    func presentTrack(trackViewController: TrackViewController)
    
}

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackAlbumNameLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    
    
    //MARK: - Public properties
    
    static let identifier = "PlaylistCollectionViewCell"
    weak var delegate: PlaylistCollectionViewCellDelegate?
    
    //MARK: - Private properties
    
    private var playlistTrackItem: PlaylistTrackItem?
    
    //MARK: - Lifecycle
    
    func configureCell(playlistTrackItem: PlaylistTrackItem) {
        self.playlistTrackItem = playlistTrackItem
        if let imageUrl = playlistTrackItem.track.album.images.first?.url, imageUrl != "" {
            trackImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        trackAlbumNameLabel.text = playlistTrackItem.track.album.name
        trackNameLabel.text = playlistTrackItem.track.name
    }
    
}

//MARK: - IBActions -

private extension PlaylistCollectionViewCell {
    
    @IBAction func didTapTrackDetailsButton(_ sender: Any) {
        guard let track = playlistTrackItem else {
            debugPrint("no track")
            return
        }
        guard let trackViewController = UIStoryboard.Storyboard.track.viewController as? TrackViewController else { return }
        trackViewController.setTrack(track: .playlistTrackItem(track: track))
        delegate?.presentTrack(trackViewController: trackViewController)
    }
    
}
