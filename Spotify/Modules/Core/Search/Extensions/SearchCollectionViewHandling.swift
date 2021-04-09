//
//  SearchCollectionViewExtension.swift
//  Spotify
//
//  Created by Dino Martan on 08/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SafariServices

//MARK: - Collection view delegates

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .categories: return categories.count
        case .albums: return albums.count
        case .artists: return artists.count
        case .tracks: return tracks.count
        case .playlists: return playlists.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCategoriesCollectionViewCell.identifier, for: indexPath) as? SearchCategoriesCollectionViewCell else { return UICollectionViewCell() }
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.configureCell(category: categories[indexPath.row])
            return cell
        case .albums:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchAlbumsCollectionViewCell.identifier, for: indexPath) as? SearchAlbumsCollectionViewCell else { return UICollectionViewCell() }
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.configureCell(album: albums[indexPath.row])
            return cell
        case .artists:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchArtistsCollectionViewCell.identifier, for: indexPath) as? SearchArtistsCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(artist: artists[indexPath.row])
            return cell
        case .tracks:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchTracksCollectionViewCell.identifier, for: indexPath) as? SearchTracksCollectionViewCell else { return UICollectionViewCell() }
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.configureCell(track: tracks[indexPath.row])
            return cell
        case .playlists:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPlaylistsCollectionViewCell.identifier, for: indexPath) as? SearchPlaylistsCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(playlist: playlists[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchCollectionReusableView.identifier, for: indexPath) as? SearchCollectionReusableView else { return UICollectionReusableView() }
        header.configureHeader()
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let type = sections[indexPath.section]
        switch type {
        case .categories:
            let category = categories[indexPath.row]
            APICaller.shared.getCategoryPlaylists(for: category) { categoryPlaylistsResponse in
                guard let categoryPlaylistsViewController = UIStoryboard.Storyboard.categoryPlaylists.viewController as? CategoryPlaylistsViewController else { return }
                categoryPlaylistsViewController.setPlaylists(categoryName: category.name, playlists: categoryPlaylistsResponse.playlists.items)
                self.navigationController?.pushViewController(categoryPlaylistsViewController, animated: true)
            } failure: { error in
                // to do - handle error
            }
        case .albums:
            let album = albums[indexPath.row]
            let newReleasesItem = NewReleasesItem(albumType: album.type, artists: nil, availableMarkets: album.availableMarkets, externalUrls: nil, href: album.href, id: album.id, images: [APIImage(height: nil, url: album.images.first?.url ?? "", width: nil)], name: album.name, type: album.type, uri: album.uri)
            guard let albumViewController = UIStoryboard.Storyboard.album.viewController as? AlbumViewController else { return }
            albumViewController.setAlbum(album: newReleasesItem)
            navigationController?.pushViewController(albumViewController, animated: true)
        case .artists:
            let artist = artists[indexPath.row]
            guard let url = URL(string: artist.externalUrls?.spotify ?? "") else { return }
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        case .tracks:
            // setting current track as the first one in array of tracks and playing the whole list
            let track = tracks[indexPath.row]
            var allTracks = tracks
            allTracks.remove(at: indexPath.row)
            allTracks.insert(track, at: 0)
            PlaybackPresenter.shared.songPlayer(modelType: .searchTrackItem(viewController: self, data: allTracks))
        case .playlists:
            let playlist = playlists[indexPath.row]
            let playlistItem = PlaylistItem(collaborative: playlist.collaborative, itemDescription: playlist.itemDescription, externalUrls: nil, href: playlist.href, id: playlist.id, images: [APIImage(height: nil, url: playlist.images.first?.url ?? "", width: nil)], name: playlist.name, owner: nil, itemPublic: nil, snapshotID: playlist.snapshotID, tracks: nil, type: playlist.type, uri: playlist.uri)
            guard let playlistViewController = UIStoryboard.Storyboard.playlist.viewController as? PlaylistViewController else { return }
            playlistViewController.setPlaylist(playlist: playlistItem)
            navigationController?.pushViewController(playlistViewController, animated: true)
        }
    }
    
}
