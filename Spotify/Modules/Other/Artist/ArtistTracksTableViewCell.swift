//
//  ArtistPlaylistsTableViewCell.swift
//  Spotify
//
//  Created by Dino Martan on 14/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

protocol ArtistTracksTableViewCellDelegate: AnyObject {
    
    func showTrackDetails(trackViewController: TrackViewController)
    
}

class ArtistTracksTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Public properties
    
    static let identifier = "ArtistTracksTableViewCell"
    weak var delegate: ArtistTracksTableViewCellDelegate?
    
    //MARK: - Private properties
    
    private var tracks: [ArtistsTrack] = []
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func configureCell(tracks: [ArtistsTrack]) {
        self.tracks = tracks
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension ArtistTracksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistTracksCollectionViewCell.identifier, for: indexPath) as? ArtistTracksCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(track: tracks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let trackViewController = UIStoryboard.Storyboard.track.viewController as? TrackViewController else { return }
        trackViewController.setTrack(track: .searchTrackItem(track: ModelConverter.artistsTrackToSearchTrackItem(artistsTrack: tracks[indexPath.row])))
        delegate?.showTrackDetails(trackViewController: trackViewController)
    }
    
}
