//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class PlaylistViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var playlistImageView: UIImageView!
    @IBOutlet private weak var playlistNameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Private properties
    
    var playlist: PlaylistItem? = nil
    var playlistDetails: PlaylistResponse? = nil
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setPlaylist(playlist: PlaylistItem) {
        self.playlist = playlist
    }

}

//MARK: - Public extensions -

extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = playlistDetails?.tracks.items.count else { return 0 }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistCollectionViewCell.identifier, for: indexPath) as? PlaylistCollectionViewCell else { return PlaylistCollectionViewCell() }
        guard let playlistTrackItem = playlistDetails?.tracks.items[indexPath.row] else { return PlaylistCollectionViewCell() }
        cell.configureCell(playlistTrackItem: playlistTrackItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

//MARK: - Private extensions -

private extension PlaylistViewController {
    
    private func setupView() {
        title = playlist?.name ?? "Playlist"
        setShadowOnImageView()
        
        let group = DispatchGroup()
        group.enter()
        guard let playlist = self.playlist else {
            // to do - handle error
            group.leave()
            return
        }
        APICaller.shared.getPlaylist(for: playlist) { playlistResponse in
            self.playlistDetails = playlistResponse
            group.leave()
            self.updateUI()
        } failure: { _ in
            group.leave()
            // to do - handle error
        }
        
        group.notify(queue: .main) {
            self.configureCollectionView()
        }
    }
    
    private func setShadowOnImageView() {
        playlistImageView.layer.shadowOpacity = 0.3
        playlistImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        playlistImageView.layer.shadowRadius = 10
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (_ , _ ) -> NSCollectionLayoutSection? in
        // Item
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        let verticalGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupLayoutSize, subitem: item, count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: verticalGroup)
        
        return section
        })
    
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateUI() {
        guard let playlistDetails = self.playlistDetails else {
            // to do - handle error
            return
        }
        playlistImageView.sd_setImage(with: URL(string: playlistDetails.images.first?.url ?? ""), completed: nil)
        playlistNameLabel.text = playlistDetails.name
        
    }
    
}

//MARK: - IBActions

extension PlaylistViewController {
    
    @IBAction func didTapPlayAllButton(_ sender: Any) {
        guard let tracks = playlistDetails?.tracks.items else {
            // to do - handle error
            return
        }
        
        // to do - play all
    }
    
}
