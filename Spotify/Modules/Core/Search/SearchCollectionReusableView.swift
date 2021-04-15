//
//  SearchCollectionReusableView.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

protocol SearchCollectionReusableViewDelegate: AnyObject {
    func searchDidChange(searchText: String)
    func searchDidEmpty()
}

class SearchCollectionReusableView: UICollectionReusableView {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    //MARK: - Public properties
    
    static let identifier = "SearchCollectionReusableView"
    weak var delegate: SearchCollectionReusableViewDelegate?
    
    //MARK: - Lifecycle
    
    func configureHeader() {
        searchBar.delegate = self
    }

}

extension SearchCollectionReusableView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" { delegate?.searchDidEmpty() }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchDidChange(searchText: searchBar.text ?? "")
    }
    
}
