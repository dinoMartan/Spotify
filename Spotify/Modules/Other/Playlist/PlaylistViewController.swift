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
    
    private var playlist: PlaylistItem?
    private var playlistDetails: PlaylistResponse?
    private var isCurrentUsersPlaylist = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setIsCurrentUsersPlaylist(with isUsersPlaylist: Bool) {
        isCurrentUsersPlaylist = isUsersPlaylist
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
        cell.presentTrackDelegate = self
        cell.deleteTrackDelegate = self
        cell.setIsCurrentUsersPlaylist(with: isCurrentUsersPlaylist)
        cell.configureCell(playlistTrackItem: playlistTrackItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let track = playlistDetails?.tracks.items[indexPath.row] else { return }
        PlaybackPresenter.shared.songPlayer(modelType: .playlistTrackItem(viewController: self, data: [track]))
    }
    
}

extension PlaylistViewController: PlaylistCollectionViewCellPresentTrackDelegate {
    
    func presentTrack(trackViewController: TrackViewController) {
        present(trackViewController, animated: true, completion: nil)
    }
    
}

extension PlaylistViewController: PlaylistCollectionViewCellDeleteTrackDelegate {
    
    func deleteTrackFromPlaylist(trackUri: String) {
        guard let playlist = playlist else {
            // to do - handle error
            return
        }
        
        let alert = UIAlertController(title: "Are you sure you want to delete track from playlist?", message: "This action cannot be undone.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            APICaller.shared.deleteTrackFromPlaylist(playlistId: playlist.id, trackUri: trackUri) {
                self.fetchPlaylistDetails()
                self.collectionView.reloadData()
            } failure: { error in
                // to do - handle error
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - Private extensions -

private extension PlaylistViewController {
    
    private func setupView() {
        title = playlist?.name ?? "Playlist"
        setShadowOnImageView()
        fetchPlaylistDetails()
        configureCollectionView()
    }
    
    private func fetchPlaylistDetails() {
        let group = DispatchGroup()
        group.enter()
        guard let playlist = self.playlist else {
            // to do - handle error
            group.leave()
            return
        }
        APICaller.shared.getPlaylistDetails(for: playlist) { [unowned self] playlistResponse in
            playlistDetails = playlistResponse
            group.leave()
            updateUI()
        } failure: { _ in
            group.leave()
            // to do - handle error
        }
        
        group.notify(queue: .main) {
            self.collectionView.reloadData()
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
        
        if let imageUrl = playlistDetails.images.first?.url, imageUrl != "" {
            playlistImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
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
        PlaybackPresenter.shared.songPlayer(modelType: .playlistTrackItem(viewController: self, data: tracks))
    }
    
}
