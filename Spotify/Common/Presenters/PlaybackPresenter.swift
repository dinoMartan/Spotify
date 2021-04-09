//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Dino Martan on 08/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import AVFoundation

struct PlayerTrack {
    
    let artist: PlayerTrackArtist
    let name: String
    let href: String
    let id: String
    let image: String
    let previewUrl: String?
    
}

struct PlayerTrackArtist {
    
  let name: String
  let externalUrl: String
    
}

protocol PlayerDataSource: AnyObject {
    
    var songName: String? { get }
    var subtitle: String? { get }
    var imageUrl: URL? { get }
    
}

final class PlaybackPresenter {
    
    //MARK: - Public properties
    
    static let shared = PlaybackPresenter()
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    //MARK: - Private properties
    
    private var track: PlayerTrack?
    private var tracks: [PlayerTrack] = []
    
    private let playerViewController = UIStoryboard.Storyboard.player.viewController as? PlayerViewController
    
    private var currentTrack: PlayerTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        return nil
    }
    
    //MARK: - Lifecycle
    
    private func playSingleTrack(on viewController: UIViewController, with track: PlayerTrack) {
        // to do - load url and play from url on avplayer
        
        guard let playerViewController = playerViewController else {
            // to do - handle error
            return
        }
        playerViewController.dataSource = self
        playerViewController.deletate = self
        viewController.present(playerViewController, animated: true) { [unowned self] in
            // to do - handle player
        }
    }
    
    private func playMultipleTracks(on viewController: UIViewController, with tracks: [PlayerTrack]) {
        guard let playerViewController = UIStoryboard.Storyboard.player.viewController as? PlayerViewController else {
            // to do - handle error
            return
        }
        playerViewController.dataSource = self
        playerViewController.deletate = self
        viewController.present(playerViewController, animated: true) { [unowned self] in
            // to do - handle player
        }
    }
    
}

//MARK: - Public extensions -

// getting data from view controllers
extension PlaybackPresenter {
    
    func startTrackPlayback(viewController: UIViewController, track: SearchTracksItem) {
        let playerTrack = searchTrackToPlayerTrack(searchTrackItem: track)
        playSingleTrack(on: viewController, with: playerTrack)
    }
    
    func startTrackPlayback(from viewController: UIViewController, track: AudioTrack, albumImage: String) {
        let playerTrack = audioTrackToPlayerTrack(audioTrack: track, albumImage: albumImage)
        playSingleTrack(on: viewController, with: playerTrack)
    }
    
    func startTrackPlayback(from viewController: UIViewController, track: PlaylistTrackItem) {
        let playerTrack = playlistTrackItemToPlayerTrack(playlistTrackItem: track)
        playSingleTrack(on: viewController, with: playerTrack)
    }
    
    func startMultipleTracksPlayback(from viewController: UIViewController, tracks: [AudioTrack], albumImage: String) {
        var playerTracks: [PlayerTrack] = []
        for audioTrack in tracks {
            playerTracks.append(audioTrackToPlayerTrack(audioTrack: audioTrack,albumImage: albumImage))
        }
        playMultipleTracks(on: viewController, with: playerTracks)
    }
    
    func startMultipleTracksPlayback(from viewController: UIViewController, tracks: [PlaylistTrackItem]) {
        var playerTracks: [PlayerTrack] = []
        for playlistTrack in tracks {
            playerTracks.append(playlistTrackItemToPlayerTrack(playlistTrackItem: playlistTrack))
        }
        playMultipleTracks(on: viewController, with: playerTracks)
    }
    
}


extension PlaybackPresenter: PlayerDataSource {
    
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artist.name
    }
    
    var imageUrl: URL? {
        return URL(string: currentTrack?.image ?? "")
    }
    
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    
    func didChangeSlider(value: Float) {
        // to do - handle slider change (volume change)
    }
    
    func didTapPlayPauseButton() {
        // to do - handle play pause button
    }
    
    func didTapNextButton() {
        // to do - handle next button
    }
    
    func didTapPreviousButton() {
        // to do - handle previous button
    }
    
}


//MARK: - Private extensions -

extension PlaybackPresenter {
    
    private func searchTrackToPlayerTrack (searchTrackItem: SearchTracksItem) -> PlayerTrack {
        let playerTrackArtist = PlayerTrackArtist(name: searchTrackItem.artists.first?.name ?? "", externalUrl: searchTrackItem.artists.first?.externalUrls.spotify ?? "")
        let playerTrack = PlayerTrack(artist: playerTrackArtist, name: searchTrackItem.name, href: searchTrackItem.href, id: searchTrackItem.id, image: searchTrackItem.album.images.first?.url ?? "", previewUrl: searchTrackItem.previewURL ?? "")
        return playerTrack
    }
    
    private func audioTrackToPlayerTrack (audioTrack: AudioTrack, albumImage: String) -> PlayerTrack {
        let playerTrackArtist = PlayerTrackArtist(name: audioTrack.artists.first?.name ?? "", externalUrl: audioTrack.artists.first?.externalUrls.spotify ?? "")
        let playerTrack = PlayerTrack(artist: playerTrackArtist, name: audioTrack.name, href: audioTrack.href, id: audioTrack.id, image: albumImage, previewUrl: audioTrack.previewURL ?? "")
        return playerTrack
    }
    
    private func playlistTrackItemToPlayerTrack (playlistTrackItem: PlaylistTrackItem) -> PlayerTrack {
        let  playerTrackArtist = PlayerTrackArtist(name: playlistTrackItem.track.album.name, externalUrl: playlistTrackItem.track.artists.first?.externalUrls.spotify ?? "")
        let playerTrack = PlayerTrack(artist: playerTrackArtist, name: playlistTrackItem.track.name, href: playlistTrackItem.track.href, id: playlistTrackItem.track.id, image: playlistTrackItem.track.album.images.first?.url ?? "", previewUrl: playlistTrackItem.track.previewURL ?? "")
        return playerTrack
    }
    
}
