//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    //MARK: - Private properties
    
    var album: NewReleasesItem? = nil
    var albumDetails: AlbumDetailsResponse? = nil
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchDetails()
    }
    
    func setAlbum(album: NewReleasesItem) {
        self.album = album
    }

}

//MARK: - Private extensions -

private extension AlbumViewController {
    
    private func setupView() {
        title = album?.name ?? "Album"
    }
    
    private func updateUI() {
        // to do - update ui with album details
    }
    
}

private extension AlbumViewController {
    
    private func fetchDetails() {
        guard let album = self.album else {
            // to do - handle error
            return
        }
        APICaller.shared.getAlbumDetails(for: album) { albumDetailsResponse in
            self.albumDetails = albumDetailsResponse
            debugPrint(albumDetailsResponse)
            self.updateUI()
        } failure: { _ in
            // to do - handle error
        }
    }
    
}
