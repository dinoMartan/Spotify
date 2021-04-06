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
    
    //MARK: - Private properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var sections = [BrowseSectionType]()
    
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
        sections.append(.newReleases(viewModels: newAlbums.compactMap({
            return NewRelesesCellViewModel(name: $0.name ?? "-", artworkUrl: URL(string: $0.images?.first?.url ?? ""), artistName: $0.artists?.first?.name ?? "-")
        })))
        
        sections.append(.featuredPlaylists(viewModels: playlists.compactMap({
            return FeaturedPlaylistsCellViewModel(name: $0.name, artworkURL: URL(string: $0.images.first?.url ?? ""), type: $0.owner.type)
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
    
}

//MARK: - Actions -

extension HomeViewController {
    
    @IBAction func didPressButton(_ sender: Any) {
        let settingsViewController = UIStoryboard.Storyboard.settings.viewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @IBAction func didTapSettingsButton(_ sender: Any) {
        let settingsViewController = UIStoryboard.Storyboard.settings.viewController
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}
