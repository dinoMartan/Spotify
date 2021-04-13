//
//  SearchDeletageExtension.swift
//  Spotify
//
//  Created by Dino Martan on 08/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

//MARK: - Search delegate

extension SearchViewController: SearchCollectionReusableViewDelegate {
    
    func searchDidChange(searchText: String) {
        view.endEditing(true)
        
        guard searchText != "" else {
            restoreCategories()
            return
        }
        
        // if text isn't empty, execute search
        APICaller.shared.search(on: self, with: searchText) {[unowned self] searchResponse in
            albums = searchResponse.albums.items
            artists = searchResponse.artists.items
            tracks = searchResponse.tracks.items
            playlists = searchResponse.playlists.items
            
            self.categories.removeAll()
            self.collectionView.reloadData()
        } failure: { error in
            // to do - handle error
        }
    }
    
    func searchDidEmpty() {
        restoreCategories()
    }
    
    private func restoreCategories() {
        APICaller.shared.getAllCategories(on: self) { [unowned self] allCategoriesResponse in
            albums.removeAll()
            artists.removeAll()
            tracks.removeAll()
            playlists.removeAll()
            categories = allCategoriesResponse.response.categories
            collectionView.reloadData()
        } failure: { error in
            // to do - handle error
        }
    }
    
}
