//
//  CreatePlaylistViewController.swift
//  Spotify
//
//  Created by Dino Martan on 10/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

enum DidCreateNewPlaylist {
    
    case success
    case failure(error: Error?)
    
}

protocol CreatePlaylistViewControllerDeletage: AnyObject {
    
    func didCreateNewPlaylist(completion: DidCreateNewPlaylist)
    
}

class CreatePlaylistViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var playlistNameTextField: UITextField!
    
    //MARK: - Public properties
    
    weak var delegate: CreatePlaylistViewControllerDeletage?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - Private extensions -

private extension CreatePlaylistViewController {
    
    private func createPlaylist() {
        guard let playlistName = playlistNameTextField.text else {
            // to do - handle error
            return
        }
        
        APICaller.shared.createUserPlaylist(on: self, name: playlistName) {
            self.delegate?.didCreateNewPlaylist(completion: .success)
            self.dismiss(animated: true, completion: nil)
        } failure: { error in
            self.delegate?.didCreateNewPlaylist(completion: .failure(error: error))
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    private func checkTextField() -> Bool {
        guard let playlistName = playlistNameTextField.text, !playlistName.isEmpty else { return false }
        return true
    }
    
}

//MARK: - IBActions

private extension CreatePlaylistViewController {
    
    @IBAction func didTapCancleButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCreateButton(_ sender: Any) {
        if checkTextField() { createPlaylist() }
        else {
            let alert = Alerter.getAlert(myTitle: "Error", error: "Playlist name is missing!", button: "OK")
            present(alert, animated: true, completion: nil)
        }
    }
    
}
