//
//  ArtistViewController.swift
//  Spotify
//
//  Created by Dino Martan on 14/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import SDWebImage

class ArtistViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Private properties
    
    private var artist: SearchArtistsItem?
    private var artistsAlbums: SearchAlbums?
    private var artistsTracks: [ArtistsTrack]?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setArtist(artist: SearchArtistsItem) {
        self.artist = artist
    }

}

//MARK: - Private extensions -

private extension ArtistViewController {
    
    private func setupView() {
        fetchData()
        configureTableView()
        updateUI()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func updateUI() {
        guard let artist = artist else { return }
        title = artist.name
        artistImageView.sd_setImage(with: URL(string: artist.images.first?.url ?? ""), completed: nil)
        artistNameLabel.text = artist.name
    }
    
    private func fetchData() {
        fetchArtistsAlbums()
        fetchArtistsTopTracks()
    }
    
    private func fetchArtistsTopTracks() {
        guard let artist = artist else { return }
        APICaller.shared.getArtistsTopTracks(on: self, for: artist.id) { artistsTracksResponse in
            self.artistsTracks = artistsTracksResponse.tracks
            self.tableView.reloadData()
        } failure: { error in
            // to do - handle error
        }

    }
    
    private func fetchArtistsAlbums() {
        guard let artist = artist else { return }
        APICaller.shared.getArtistsAlbums(on: self, for: artist.id) { albums in
            self.artistsAlbums = albums
            self.tableView.reloadData()
        } failure: { error in
            // to do - handle error
        }
    }
    
}

//MARK: - TableView Delegate/DataSource

extension ArtistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistAlbumsTableViewCell.identifier) as? ArtistAlbumsTableViewCell else { return UITableViewCell() }
            guard let artistsAlbums = artistsAlbums else { return UITableViewCell() }
            cell.configureCell(albums: artistsAlbums)
            cell.delegate = self
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTracksTableViewCell.identifier) as? ArtistTracksTableViewCell else { return UITableViewCell() }
            guard let artistsTracks = artistsTracks else { return UITableViewCell() }
            cell.configureCell(tracks: artistsTracks)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Albums" }
        else { return "Top tracks" }
    }
    
}

//MARK: - TableViewCell Delegates

extension ArtistViewController: ArtistAlbumsTableViewCellDelegate {
    
    func showAlbumDetails(viewController: AlbumViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension ArtistViewController: ArtistTracksTableViewCellDelegate {
    
    func showTrackDetails(trackViewController: TrackViewController) {
        present(trackViewController, animated: true, completion: nil)
    }
    
}
