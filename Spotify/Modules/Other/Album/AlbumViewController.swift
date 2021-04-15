//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Dino Martan on 06/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Private properties
    
    var album: NewReleasesItem? = nil
    var albumDetails: AlbumDetailsResponse? = nil
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setAlbum(album: NewReleasesItem) {
        self.album = album
    }

}

//MARK: - Public extensions -

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let audioTracks = albumDetails?.tracks.audioTracks else { return 0 }
        return audioTracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        guard let audioTrack = albumDetails?.tracks.audioTracks[indexPath.row] else { return cell }
        cell.delegate = self
        cell.configureCell(audioTrack: audioTrack)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AlbumHeaderCollectionReusableView.identifier, for: indexPath) as? AlbumHeaderCollectionReusableView,
              kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        guard let albumDetails = self.albumDetails else { return header }
        header.configureHeader(albumDetails: albumDetails)
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let track = albumDetails?.tracks.audioTracks[indexPath.row
        ] else { return }
        PlaybackPresenter.shared.songPlayer(modelType: .audioTrack(viewController: self, data: [track], albumImage: albumDetails?.images.first?.url ?? ""))
    }
    
}

extension AlbumViewController: AlbumHeaderCollectionReusableViewDelegate {
    
    func didTapPlayAllButton() {
        // to do - play all
        guard let audioTracks = albumDetails?.tracks.audioTracks else { return }
        PlaybackPresenter.shared.songPlayer(modelType: .audioTrack(viewController: self, data: audioTracks, albumImage: albumDetails?.images.first?.url ?? ""))
    }
    
}

//MARK: - Private extensions -

private extension AlbumViewController {
    
    private func setupView() {
        title = album?.name ?? "Album"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let group = DispatchGroup()
        group.enter()
        guard let album = self.album else {
            group.leave()
            // to do - handle error
            return
        }
        APICaller.shared.getAlbumDetails(on: self, for: album) { albumDetailsResponse in
            self.albumDetails = albumDetailsResponse
            group.leave()
        } failure: { _ in
            group.leave()
            // to do - handle error
        }
        
        group.notify(queue: .main) {
            self.configureCollectionView()
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { ( _ , _ ) -> NSCollectionLayoutSection? in
            // Item
            let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            // Group
            let verticalGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupLayoutSize, subitem: item, count: 1)
            // Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.boundarySupplementaryItems = self.getSupplementaryView()
            
            return section
        }
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getSupplementaryView() -> [NSCollectionLayoutBoundarySupplementaryItem] {
        let supplementaryItemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(280))
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementaryItemLayoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return supplementaryViews
    }
    
}

extension AlbumViewController: AlbumCollectionViewCellDelegate {
    
    func presentTrack(trackViewController: TrackViewController) {
        present(trackViewController, animated: true, completion: nil)
    }
    
}
