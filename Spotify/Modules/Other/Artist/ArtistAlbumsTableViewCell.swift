//
//  ArtistTableViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 14/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

protocol ArtistAlbumsTableViewCellDelegate: AnyObject {
    func showAlbumDetails(viewController: AlbumViewController)
}

class ArtistAlbumsTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Public properties
    
    static let identifier = "ArtistAlbumsTableViewCell"
    weak var delegate: ArtistAlbumsTableViewCellDelegate?
    
    //MARK: - Private properties
    
    private var albums: SearchAlbums?
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func configureCell(albums: SearchAlbums) {
        self.albums = albums
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }

}

extension ArtistAlbumsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let albums = albums else { return 0 }
        return albums.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistAlbumsCollectionViewCell.identifier, for: indexPath) as? ArtistAlbumsCollectionViewCell else { return UICollectionViewCell() }
        guard let albums = albums else { return UICollectionViewCell() }
        cell.configureCell(album: albums.items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let albums = albums, let albumViewController = UIStoryboard.Storyboard.album.viewController as? AlbumViewController else { return }
        let album = albums.items[indexPath.row]
        albumViewController.setAlbum(album: ModelConverter.searchAlbumElementToNewRelesesItem(searchAlbumElement: album))
        delegate?.showAlbumDetails(viewController: albumViewController)
    }
    
}
