//
//  PlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

protocol PlaylistCollectionViewCellPresentTrackDelegate: AnyObject {
    
    func presentTrack(trackViewController: TrackViewController)
    
}

protocol PlaylistCollectionViewCellDeleteTrackDelegate: AnyObject {
    func deleteTrackFromPlaylist(trackUri: String)
}

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackAlbumNameLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var deleteTrackFromPlaylistButton: UIButton!
    
    //MARK: - Public properties
    
    static let identifier = "PlaylistCollectionViewCell"
    weak var presentTrackDelegate: PlaylistCollectionViewCellPresentTrackDelegate?
    weak var deleteTrackDelegate: PlaylistCollectionViewCellDeleteTrackDelegate?
    
    
    //MARK: - Private properties
    
    private var isCurrentUsersPlaylist = false
    private var playlistTrackItem: PlaylistTrackItem?
    
    //MARK: - Lifecycle
    
    func setIsCurrentUsersPlaylist(with isCurrentUsersPlaylist: Bool) {
        self.isCurrentUsersPlaylist = isCurrentUsersPlaylist
    }
    
    func configureCell(playlistTrackItem: PlaylistTrackItem) {
        // to do - hide/show delete button
        deleteTrackFromPlaylistButton.isHidden = !isCurrentUsersPlaylist
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
            // to do - handle error
            return
        }
        guard let trackViewController = UIStoryboard.Storyboard.track.viewController as? TrackViewController else { return }
        trackViewController.setTrack(track: .playlistTrackItem(track: track))
        presentTrackDelegate?.presentTrack(trackViewController: trackViewController)
    }
    
    @IBAction func didTapDeleteTrackFromPlaylistButton(_ sender: Any) {
        guard let track = playlistTrackItem else { return }
        deleteTrackDelegate?.deleteTrackFromPlaylist(trackUri: track.track.uri)
    }
    
}
