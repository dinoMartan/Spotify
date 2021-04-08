//
//  HomeViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

enum BrowseSectionType {
    
    case newReleases(viewModels: [NewRelesesCellViewModel]) // 1
    case featuredPlaylists(viewModels: [FeaturedPlaylistsCellViewModel]) // 2
    case recommendedTracks(viewModels: [RecommendedTrackCellViewModel]) // 3
    
}

class HomeViewController: DMViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private properties
    
    private var sections = [BrowseSectionType]()
    
    private var newAlbums: [NewReleasesItem] = []
    private var tracks: [AudioTrack] = []
    private var playlists: [PlaylistItem] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fetchData()
        setupCollectionView()
    }
    
}

//MARK: - Public extensions -

extension HomeViewController {
    
    func configureModels(newAlbums: [NewReleasesItem], tracks: [AudioTrack], playlists: [PlaylistItem]) {
        self.newAlbums = newAlbums
        self.tracks = tracks
        self.playlists = playlists
        
        sections.append(.newReleases(viewModels: newAlbums.compactMap({
            return NewRelesesCellViewModel(name: $0.name ?? "-", artworkUrl: URL(string: $0.images?.first?.url ?? ""), artistName: $0.artists?.first?.name ?? "-")
        })))
        
        sections.append(.featuredPlaylists(viewModels: playlists.compactMap({
            guard let ownerType = $0.owner?.type else { fatalError() }
            return FeaturedPlaylistsCellViewModel(name: $0.name, artworkURL: URL(string: $0.images.first?.url ?? ""), type: ownerType)
        })))
        
        sections.append(.recommendedTracks(viewModels: tracks.compactMap({
            return RecommendedTrackCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "")
        })))
        
        collectionView?.reloadData()
    }
    
}

//MARK: - Private extensions -

private extension HomeViewController {
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            self.createSectionLayout(section: sectionIndex)
        }
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0: return createNewReleasesSection()
        case 1: return createFeaturedPlaylistsSection()
        case 2: return createRecommendedTracksSection()
        default:  return createDefaultSection()
        }
    }
    
}

//MARK: - Delegate and data source extension -

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        
        case .newReleases(let viewModels):
            return viewModels.count
        case .featuredPlaylists(let viewModels):
            return viewModels.count
        case .recommendedTracks(let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        
        switch type {
        case .newReleases(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier, for: indexPath) as? NewReleaseCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.row]
            cell.configureCell(with: viewModel)
            return cell
            
        case .featuredPlaylists(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier, for: indexPath) as? FeaturedPlaylistCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configureCell(data: viewModel)
            return cell
            
        case .recommendedTracks(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configureCell(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = sections[indexPath.section]
        switch section {
        
        case .newReleases:
            let album = newAlbums[indexPath.row]
            guard let albumViewController = UIStoryboard.Storyboard.album.viewController as? AlbumViewController else { return }
            albumViewController.setAlbum(album: album)
            navigationController?.pushViewController(albumViewController, animated: true)
        case .featuredPlaylists:
            let playlist = playlists[indexPath.row]
            guard let playlistViewController = UIStoryboard.Storyboard.playlist.viewController as? PlaylistViewController else { return }
            playlistViewController.setPlaylist(playlist: playlist)
            navigationController?.pushViewController(playlistViewController, animated: true)
        case .recommendedTracks:
            let track = tracks[indexPath.row]
            PlaybackPresenter.shared.startTrackPlayback(from: self, track: track, albumImage: "")
            break
        }
    }
    
    // to do - strings to constants
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let type = sections[indexPath.section]
        switch type {
        case .newReleases:
            header.configureHeader(title: "New releases albums")
        case .featuredPlaylists:
            header.configureHeader(title: "Featured playlists")
        case .recommendedTracks:
            header.configureHeader(title: "Recommended tracks")
        }
        return header
    }
    
}
