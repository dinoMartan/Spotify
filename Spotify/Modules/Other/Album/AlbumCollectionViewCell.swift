//
//  AlbumCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

protocol AlbumCollectionViewCellDelegate: AnyObject {
    
    func presentTrack(trackViewController: TrackViewController)
    
}

class AlbumCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!

    //MARK: - Public properties
    
    static let identifier = "AlbumCollectionViewCell"
    weak var delegate: AlbumCollectionViewCellDelegate?
    
    //MARK: - Private properties
    
    private var audioTrack: AudioTrack?
    
    //MARK: - Lifecycle
    
    func configureCell(audioTrack: AudioTrack) {
        self.audioTrack = audioTrack
        artistNameLabel.text = audioTrack.artists.first?.name
        trackNameLabel.text = audioTrack.name
    }
    
}

//MARK: - IBActions -

extension AlbumCollectionViewCell {
    
    @IBAction func didTapShowTrackDetailsButton(_ sender: Any) {
        guard let track = audioTrack else {
            // to do - handle error
            return
        }
        guard let trackViewController = UIStoryboard.Storyboard.track.viewController as? TrackViewController else { return }
        trackViewController.setTrack(track: .audioTrack(track: track))
        delegate?.presentTrack(trackViewController: trackViewController)
    }
    
}
