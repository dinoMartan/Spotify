//
//  AlbumHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

protocol AlbumHeaderCollectionReusableViewDelegate: AnyObject {
    func didTapPlayAllButton()
}

class AlbumHeaderCollectionReusableView: UICollectionReusableView {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var albumTitleLabel: UILabel!
    
    //MARK: - Public properties
    
    static let identifier = "AlbumHeaderCollectionReusableView"
    weak var delegate: AlbumHeaderCollectionReusableViewDelegate?
    
    //MARK: - Lifecycle
    
    func configureHeader(albumDetails: AlbumDetailsResponse) {
        albumImageView.sd_setImage(with: URL(string: albumDetails.images.first?.url ?? ""), completed: nil)
        albumTitleLabel.text = albumDetails.name
        setShadowOnImageView()
    }
    
    private func setShadowOnImageView() {
        albumImageView.layer.shadowOpacity = 0.3
        albumImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        albumImageView.layer.shadowRadius = 10
    }
}

//MARK: - IBActions

extension AlbumHeaderCollectionReusableView {
    
    @IBAction func didTapPlayAllButton(_ sender: Any) {
        delegate?.didTapPlayAllButton()
    }
    
}
