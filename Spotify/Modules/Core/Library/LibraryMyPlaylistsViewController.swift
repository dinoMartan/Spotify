//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class LibraryMyPlaylistsViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var noPlaylistsView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addNewPlaylistButton: UIButton!
    @IBOutlet private weak var playlistSearchBar: UISearchBar!
    
    //MARK: - Private properties
    
    private var currentUsersPlaylists: Playlists?
    private var allCurrentUsersPlaylists: Playlists?
    private var track: TrackInputType?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCurrentUsersPlaylists()
    }
    
    // if the track is set, tapping on playlist will result in
    // track being added to the playlist
    // if the track is not set, tapping will show
    // all tracks from playlist
    func setTrack(track: TrackInputType) {
        self.track = track
    }
    
}

//MARK: - Private extensions -

//MARK: - ViewControllerSetup

private extension LibraryMyPlaylistsViewController {
    
    private func setupView() {
        fetchCurrentUsersPlaylists()
        configureTableView()
        configureHeader()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureHeader() {
        addNewPlaylistButton.layer.cornerRadius = 10
        addNewPlaylistButton.layer.borderWidth = 2
        addNewPlaylistButton.layer.borderColor = UIColor.black.cgColor
        playlistSearchBar.delegate = self
    }
    
    private func configureNoPlaylistView() {
        guard let playlists = currentUsersPlaylists, !playlists.items.isEmpty else {
            noPlaylistsView.isHidden = false
            return
        }
        noPlaylistsView.isHidden = true
    }
    
    private func deletePlaylist(playlistId: String) {
        APICaller.shared.deleteUsersPlaylist(on: self, playlistId: playlistId) {
            self.fetchCurrentUsersPlaylists()
        } failure: { error in
            // to do - handle error
        }
    }
    
}

//MARK: - Data handling

private extension LibraryMyPlaylistsViewController {

    private func fetchCurrentUsersPlaylists() {
        APICaller.shared.getCurrentUserPlaylists(on: self) { [weak self] playlists in
            self?.currentUsersPlaylists = playlists
            self?.allCurrentUsersPlaylists = playlists
            self?.tableView.reloadData()
            self?.configureNoPlaylistView()
        } failure: { error in
            // to do - handle error
        }
    }

}
//MARK: - IBActions -

private extension LibraryMyPlaylistsViewController {
    
    // view behind table view
    @IBAction func didTapCreatePlaylistButton(_ sender: Any) {
        guard let createPlaylistViewController = UIStoryboard.Storyboard.createPlaylist.viewController as? CreatePlaylistViewController else { return }
        createPlaylistViewController.delegate = self
        createPlaylistViewController.modalPresentationStyle = .fullScreen
        present(createPlaylistViewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapAddNewPlaylistButton(_ sender: Any) {
        guard let createPlaylistViewController = UIStoryboard.Storyboard.createPlaylist.viewController as? CreatePlaylistViewController else { return }
        createPlaylistViewController.delegate = self
        createPlaylistViewController.modalPresentationStyle = .fullScreen
        present(createPlaylistViewController, animated: true, completion: nil)
    }
    
}

//MARK: - SearchBar delegate

extension LibraryMyPlaylistsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard currentUsersPlaylists != nil, allCurrentUsersPlaylists != nil else { return }
        let allItems = allCurrentUsersPlaylists?.items
        
        if searchText == "" {
            currentUsersPlaylists?.items = allItems!
            tableView.reloadData()
        }
        else {
            var filteredPlaylistItems: [PlaylistItem] = []
            for playlistItem in allItems! {
                if playlistItem.name.lowercased().contains(searchText.lowercased()) {
                    filteredPlaylistItems.append(playlistItem)
                }
            }
            currentUsersPlaylists?.items = filteredPlaylistItems
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        playlistSearchBar.resignFirstResponder()
    }
    
}

//MARK: - CreatePlaylist delegate

extension LibraryMyPlaylistsViewController: CreatePlaylistViewControllerDeletage {
    
    func didCreateNewPlaylist(completion: DidCreateNewPlaylist) {
        switch completion {
        case .success:
            fetchCurrentUsersPlaylists()
            break
        case .failure(_):
            let alert = Alerter.getAlert(myTitle: .somethingWentWrong, myMessage: .didntCreatePlaylist, button: .shame)
            present(alert, animated: true, completion: nil)
        }
    }
    
}

//MARK: - Tableview delegates

extension LibraryMyPlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let playlists = currentUsersPlaylists else { return 0 }
        return playlists.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewCell.identifier) as? LibraryTableViewCell else { return UITableViewCell() }
        guard let playlistItem = currentUsersPlaylists?.items[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(playlist: playlistItem)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let playlistItems = currentUsersPlaylists?.items else { return }
        let playlistItem = playlistItems[indexPath.row]
        
        // if track is set, add it to the selected playlist
        if let track = track {
            var newTrackUri: String
            
            switch track {
            case .searchTrackItem(let song):
                newTrackUri = song.uri
            case .audioTrack(let song):
                newTrackUri = song.uri
            case .playlistTrackItem(let song):
                newTrackUri = song.track.uri
            }
            
            APICaller.shared.addTrackToPlaylist(on: self, playlistId: playlistItem.id, trackUri: newTrackUri) {
                self.fetchCurrentUsersPlaylists()
                let alert = Alerter.getAlert(myTitle: "Adding successful", error: "Added to playlist!", button: "OK")
                self.present(alert, animated: true, completion: nil)
            } failure: { error in
                // to do - handle error
                let alert = Alerter.getAlert(myTitle: .ops, error: error, button: .shame)
                self.present(alert, animated: true, completion: nil)
            }

        }
        else {
            guard let playlistViewController = UIStoryboard.Storyboard.playlist.viewController as? PlaylistViewController else { return }
            playlistViewController.setIsCurrentUsersPlaylist(with: true)
            playlistViewController.setPlaylist(playlist: playlistItem)
            navigationController?.pushViewController(playlistViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

//MARK: - TableViewCell Delegate

extension LibraryMyPlaylistsViewController: LibraryMyPlaylistsTableViewCellDelegate {
    
    func didTapDeletePlaylistButton(playlist: PlaylistItem) {
        let alert = Alerter.getActionSheet(myTitle: playlist.name, message: .areYouSureYouWantToDeleteThisPlaylist, button: .cancel)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.deletePlaylist(playlistId: playlist.id)
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
