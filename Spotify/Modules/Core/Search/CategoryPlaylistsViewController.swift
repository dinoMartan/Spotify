//
//  CategoryPlaylistsViewController.swift
//  Spotify
//
//  Created by Dino Martan on 07/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class CategoryPlaylistsViewController: DMViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private properties
    
    var playlists: [PlaylistItem] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setPlaylists(categoryName: String, playlists: [PlaylistItem]) {
        self.playlists = playlists
        title = categoryName
    }

}

//MARK: - Public extensions -

extension CategoryPlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryPlaylistsTableViewCell.identifier) as? CategoryPlaylistsTableViewCell else { return UITableViewCell() }
        cell.configureCell(playlist: playlists[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let playlistViewController = UIStoryboard.Storyboard.playlist.viewController as? PlaylistViewController else { return }
        playlistViewController.setPlaylist(playlist: playlists[indexPath.row])
        navigationController?.pushViewController(playlistViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.deleteRow(indexPath: indexPath)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func deleteRow(indexPath: IndexPath) {
        playlists.remove(at: indexPath.row)
        tableView.reloadData()
    }

}
