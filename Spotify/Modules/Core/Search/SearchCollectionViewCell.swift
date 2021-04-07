//
//  SearchCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class SearchCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var categoryIconImageView: UIImageView!
    
    
    //MARK: - Public properties
    
    static let identifier = "SearchCollectionViewCell"
    
    //MARK: - Lifecycle
    
    func configureCell(category: Category) {
        genreLabel.text = category.name
        //backgroundColor = ColorsConstants.colors.randomElement()
        categoryIconImageView.sd_setImage(with: URL(string: category.icons?.first?.url ?? ""), completed: nil)
        
    }
    
}
