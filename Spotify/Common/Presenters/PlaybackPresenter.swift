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
    
    //MARK: - Private properties
    
    private var singlePlayer: AVPlayer?
    
    private var track: PlayerTrack?
    
    private var numberOfTracks: Int { tracks.count }
    private var currentTrackIndex: Int?
    
    private var tracks: [PlayerTrack] = []
    
    private let playerViewController = UIStoryboard.Storyboard.player.viewController as? PlayerViewController
    
    var currentTrack: PlayerTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        return nil
    }
    
    private var singleTrackIsPlaying: Bool {
        guard let singlePlayer = singlePlayer else { return false }
        if singlePlayer.timeControlStatus == .playing { return true }
        else { return false }
    }
    
    private var multipleTracksArePlaying = false
    
    //MARK: - Lifecycle
    
    private func playTrack(playerTrack: PlayerTrack) {
        guard let urlString = playerTrack.previewUrl, let url = URL(string: urlString) else {
            // to do - handle error
            debugPrint("URL not found!")
            return
        }
        track = playerTrack
        singlePlayer = AVPlayer(url: url)
        singlePlayer?.volume = 0.5
        singlePlayer?.play()
    }
    
    private func playTracks(playerTracks: [PlayerTrack]) {
        if singleTrackIsPlaying { singlePlayer?.pause() }
        tracks = playerTracks
        
        var items: [AVPlayerItem] = []
        
        for track in playerTracks {
            guard let urlString = track.previewUrl, let url = URL(string: urlString) else { continue }
            let avPlayerItem = AVPlayerItem(url: url)
            items.append(avPlayerItem)
        }
        
    }
    
    private func playSingleTrack(on viewController: UIViewController, with track: PlayerTrack) {
        guard let playerViewController = playerViewController else {
            // to do - handle error
            return
        }
        playerViewController.dataSource = self
        playerViewController.delegate = self
        playTrack(playerTrack: track)
        viewController.present(playerViewController, animated: true)
    }
    
    private func playMultipleTracks(on viewController: UIViewController, with tracks: [PlayerTrack]) {
        playTracks(playerTracks: tracks)
        
        guard let playerViewController = UIStoryboard.Storyboard.player.viewController as? PlayerViewController else {
            // to do - handle error
            return
        }
        playerViewController.dataSource = self
        playerViewController.delegate = self
        viewController.present(playerViewController, animated: true)
    }
    
}

//MARK: - Public extensions -

//MARK: user actions

extension PlaybackPresenter: PlayerViewControllerDelegate {
    
    func didChangeSlider(value: Float) {
        // to do - handle slider change (volume change)
        guard let singlePlayer = singlePlayer else { return }
        singlePlayer.volume = value
    }
    
    func didTapPlayPauseButton() {
        guard let singlePlayer = singlePlayer else { return }
        if singleTrackIsPlaying { singlePlayer.pause() }
        else { singlePlayer.play() }
    }
    
    func didTapNextButton() {
        // to do - handle next button
    }
    
    func didTapPreviousButton() {
        // to do - handle previous button
    }
    
}

// MARK: data source

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

//MARK: getting data from view controllers

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

//MARK: - Private extensions -

//MARK: data conversion

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
