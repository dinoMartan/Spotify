//
//  TrackViewController.swift
//  Spotify
//
//  Created by Dino Martan on 10/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

enum TrackInputType {
    
    case searchTrackItem(track: SearchTracksItem)
    case audioTrack(track: AudioTrack)
    case playlistTrackItem(track: PlaylistTrackItem)
    
}

class TrackViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var addToPlaylistButton: UIButton!
    
    //MARK: - Private properties
    
    var track: TrackInputType?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func setTrack(track: TrackInputType) {
        self.track = track
    }
    
}

//MARK: - Private extensions -

private extension TrackViewController {
    
    private func configureUI() {
        guard let track = track else { return }
        
        switch track {
            case .searchTrackItem(let track):
                if let imageUrl = track.album.images.first?.url, imageUrl != "" {
                    trackImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
                    trackNameLabel.text = track.name
                    artistNameLabel.text = track.artists.first?.name
                }
                
            case .audioTrack(let track):
                    trackNameLabel.text = track.name
                    artistNameLabel.text = track.artists.first?.name
                
            case .playlistTrackItem(let track):
                if let imageUrl = track.track.album.images.first?.url, imageUrl != "" {
                        trackImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
                    trackNameLabel.text = track.track.name
                    artistNameLabel.text = track.track.album.name
            }
        }
    }
    
}

//MARK: - IBActions -

extension TrackViewController {
    
    @IBAction func didTapAddToPlaylistButton(_ sender: Any) {
        guard let libraryViewController = UIStoryboard.Storyboard.library.viewController as? LibraryMyPlaylistsViewController else { return }
        guard let track = track else { return }
        libraryViewController.setTrack(track: track)
        present(libraryViewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapPlayButton(_ sender: Any) {
        guard let track = track else { return }
        switch track {
        case .searchTrackItem(let track):
            PlaybackPresenter.shared.songPlayer(modelType: .searchTrackItem(viewController: self, data: [track]))
        case .audioTrack(let track):
            PlaybackPresenter.shared.songPlayer(modelType: .audioTrack(viewController: self, data: [track], albumImage: ""))
        case .playlistTrackItem(let track):
            PlaybackPresenter.shared.songPlayer(modelType: .playlistTrackItem(viewController: self, data: [track]))
        }
        
    }
    
}
