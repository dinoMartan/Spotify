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
    case featuredPlaylists(viewModels: [NewRelesesCellViewModel]) // 2
    case recommendedTracks(viewModels: [NewRelesesCellViewModel]) // 3
    
}

class HomeViewController: DMViewController {
    
    //MARK: - Private properties
    
    private var collectionView: UICollectionView?
    private var sections = [BrowseSectionType]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
        configureCollectionView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
}

//MARK: - Private extensions -

private extension HomeViewController {
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            self.createSectionLayout(section: sectionIndex)
        }
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    private func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0: return createNewReleasesSection()
        case 1: return createFeaturedPlaylistsSection()
        case 2: return createRecommendedTracksSection()
        default:  return createDefaultSection()
        }
    }
    
    private func configureCollectionView() {
        guard let collectionView = self.collectionView else { return }
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases: NewReleasesResponse?
        var featuredPlaylists: FeaturedPlaylistsResponse?
        var recommendations: RecommendationsResponse?
        
        // new releases
        APICaller.shared.getNewReleases { newRelesesResponse in
            group.leave()
            newReleases = newRelesesResponse
        } failure: { _ in
            group.leave()
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchNewReleases, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        // featured playlists
        APICaller.shared.getFeaturedPlaylists { featuresPlaylistsResponse in
            group.leave()
            featuredPlaylists = featuresPlaylistsResponse
        } failure: { _ in
            group.leave()
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchFeaturedPlaylists, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        // recommendations
        APICaller.shared.getRecommendationGenres { recommendedGenresResponse in
            guard let seeds = self.generateGenreSeeds(genres: recommendedGenresResponse.genres) else { return }
            
            APICaller.shared.getRecommendations(genres: seeds) { recommendationsResponse in
                group.leave()
                recommendations = recommendationsResponse
            } failure: { _ in
                group.leave()
                let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchRecommendations, button: .ok)
                self.present(alert, animated: true, completion: nil)
            }
            
        } failure: { _ in
            group.leave()
            let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntFetchRecommendationGenres, button: .ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items,
                  let playlists = featuredPlaylists?.playlists.items,
                  let tracks = recommendations?.tracks else {
                return
            }
            
            self.configureModels(newAlbums: newAlbums, tracks: tracks, playlists: playlists)
        }
    }
    
    private func generateGenreSeeds(genres: [String]) -> Set<String>? {
        var seeds = Set<String>()
        while seeds.count < 5 {
            guard let random = genres.randomElement() else { continue }
            seeds.insert(random)
        }
        return seeds
    }
    

    
    private func configureModels(newAlbums: [NewReleasesItem], tracks: [AudioTrack], playlists: [PlaylistItem]) {
        sections.append(.newReleases(viewModels: newAlbums.compactMap({
            return NewRelesesCellViewModel(name: $0.name ?? "-", artworkUrl: URL(string: $0.images?.first?.url ?? ""), artistName: $0.artists?.first?.name ?? "-")
        })))
        sections.append(.featuredPlaylists(viewModels: []))
        sections.append(.recommendedTracks(viewModels: []))
        collectionView?.reloadData()
    }
    
}

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
            cell.configure(with: viewModel)
            return cell
            
        case .featuredPlaylists(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier, for: indexPath) as? FeaturedPlaylistCollectionViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .systemBlue
            return cell
            
        case .recommendedTracks(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .systemOrange
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
