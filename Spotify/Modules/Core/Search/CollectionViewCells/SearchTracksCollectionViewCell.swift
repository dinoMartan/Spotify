//
//  SearchTracksCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

protocol SearchTracksCollectionViewCellDelegate: AnyObject {
    
    func presentTrack(trackViewController: TrackViewController)
    
}

class SearchTracksCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "SearchTracksCollectionViewCell"
    weak var delegate: SearchTracksCollectionViewCellDelegate?
    
    //MARK: - Private properties
    
    private var searchTrack: SearchTracksItem?
    
    //MARK: - Lifecycle
    
    func configureCell(track: SearchTracksItem) {
        searchTrack = track
        albumImageView.sd_setImage(with: URL(string: track.album.images.first?.url ?? ""), completed: nil)
        artistLabel.text = track.artists.first?.name
        trackNameLabel.text = track.name
    }
    
}

//MARK: - IBActions -

extension SearchTracksCollectionViewCell {
    
    @IBAction func didTapShowTrackDetails(_ sender: Any) {
        guard let track = searchTrack else {
            // to do - handle error
            return
        }
        guard let trackViewController = UIStoryboard.Storyboard.track.viewController as? TrackViewController else { return }
        trackViewController.setTrack(track: .searchTrackItem(track: track))
        delegate?.presentTrack(trackViewController: trackViewController)
    }
    
}
