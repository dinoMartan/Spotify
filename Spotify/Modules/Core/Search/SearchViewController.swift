//
//  SearchViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class SearchViewController: DMViewController {
    
    enum SearchSections {
        
        case categories // 0
        case albums // 1
        case artists // 2
        case tracks // 3
        case playlists // 4
        
    }

    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Public properties
    
    var sections: [SearchSections] = [.categories, .artists, .albums, .playlists, .tracks]
    
    var categories: [Category] = []
    
    var albums: [SearchAlbumElement] = []
    var artists: [SearchArtistsItem] = []
    var tracks: [SearchTracksItem] = []
    var playlists: [SearchPlaylistsItem] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let group = DispatchGroup()
        group.enter()
        APICaller.shared.getAllCategories { allCategoriesResponse in
            self.categories = allCategoriesResponse.response.categories
            group.leave()
        } failure: { _ in
            group.leave()
            // to do - handle error
        }

        group.notify(queue: .main) {
            self.configureCollectionView()
        }
    }

}

//MARK: - Private extensions -

private extension SearchViewController {
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { ( sectionIndex , _ ) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0: return self.createCategoriesLayout()
            case 1: return self.createArtistsLayout()
            case 2: return self.createAlbumsLayout()
            case 3: return self.createPlaylistsLayout()
            case 4: return self.createTracksLayout()
            default: return self.createCategoriesLayout()
            }
            
        })
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
