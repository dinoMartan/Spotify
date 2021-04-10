//
//  LibarayPageViewController.swift
//  Spotify
//
//  Created by Dino Martan on 10/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class LibraryPageViewController: UIPageViewController {
    
    //MARK: - IBOutlets
    
    //MARK: - Private properties
    
    private let playlistsViewController = UIStoryboard.Storyboard.libraryPlaylists.viewController as? LibraryPlaylistsViewController
    private let albumsViewController = UIStoryboard.Storyboard.libraryAlbums.viewController as? LibraryAlbumsViewController
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        guard let playlistViewController = playlistsViewController, let albumsViewController = albumsViewController else { return }
        setViewControllers([playlistViewController], direction: .forward, animated: true, completion: nil)
    }

}
