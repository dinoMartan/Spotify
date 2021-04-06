//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    //MARK: - Private properties
    
    var playlist: PlaylistItem? = nil
    var playlistDetails: PlaylistResponse? = nil
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchDetails()
    }
    
    func setPlaylist(playlist: PlaylistItem) {
        self.playlist = playlist
    }

}

//MARK: - Private extensions -

private extension PlaylistViewController {
    
    private func setupView() {
        title = playlist?.name ?? "Playlist"
    }
    
    private func updateUI() {
        // to do - update ui with album details
    }
    
}

private extension PlaylistViewController {
    
    private func fetchDetails() {
        guard let playlist = self.playlist else {
            // to do - handle error
            return
        }
        APICaller.shared.getPlaylist(for: playlist) { playlistResponse in
            self.playlistDetails = playlistResponse
            debugPrint(playlistResponse)
            self.updateUI()
        } failure: { _ in
            // to do - handle error
        }
    }
    
}
