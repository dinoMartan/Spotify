//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 05/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "RecommendedTrackCollectionViewCells"
    
    //MARK: - Lifecycle
    
    func configureCell(with data: RecommendedTrackCellViewModel) {
        trackNameLabel.text = data.name
        artistNameLabel.text = data.artistName
    }
    
}
