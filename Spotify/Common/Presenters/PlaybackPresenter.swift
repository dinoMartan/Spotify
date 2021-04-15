//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Dino Martan on 08/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import AVFoundation

enum PlayerInputData {
    
    case searchTrackItem(viewController: UIViewController, data: [SearchTracksItem])
    case audioTrack(viewController: UIViewController, data: [AudioTrack], albumImage: String)
    case playlistTrackItem(viewController: UIViewController, data: [PlaylistTrackItem])
    
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
    
    private var player: AVPlayer?
    
    private var currentPlayingItem: PlayingItem? {
        guard let index = currentTrackIndex else { return nil }
        return playingItems[index]
    }
    
    private var playingItems: [PlayingItem] = []
    
    private var numberOfTracks: Int { playingItems.count }
    private var currentTrackIndex: Int?
    
    private var playerIsPlaying: Bool {
        guard let trackPlayer = player else { return false }
        if trackPlayer.timeControlStatus == .playing { return true }
        else { return false }
    }
    
    //MARK: - Lifecycle
    
    private func playTracks() {
        guard let currentPlayingItem = currentPlayingItem else { return }
        player = AVPlayer(playerItem: currentPlayingItem.avPlayerItem)
        player?.volume = PlayerConstants.defaultTrackVolume
        player?.play()
    }
    
    private func prepareTracks(playerTracks: [PlayerTrack]) -> Bool {
        if playerIsPlaying { player?.pause() }
        self.playingItems.removeAll()
        
        var playingItems: [PlayingItem] = []
        
        for track in playerTracks {
            guard let urlString = track.previewUrl, let url = URL(string: urlString), urlString != "" else { continue }
            let avPlayerItem = AVPlayerItem(url: url)
            let playingItem = PlayingItem(trackData: track, avPlayerItem: avPlayerItem)
            playingItems.append(playingItem)
        }
        
        self.playingItems = playingItems
        if self.playingItems.isEmpty {
            currentTrackIndex = nil
            return false
        }
        else {
            currentTrackIndex = 0
            return true
        }
    }
    
    private func playMultipleTracks(on viewController: UIViewController, with tracks: [PlayerTrack]) {
        if prepareTracks(playerTracks: tracks) {
            playTracks()
            guard let playerViewController = UIStoryboard.Storyboard.player.viewController as? PlayerViewController else {
                // to do - handle error
                return
            }
            playerViewController.dataSource = self
            playerViewController.delegate = self
            viewController.present(playerViewController, animated: true)
        }
        else {
            // to do - handle error
        }
    }
    
}

//MARK: - Public extensions -

//MARK: PlayerViewControllerDelegate

extension PlaybackPresenter: PlayerViewControllerDelegate {
    
    func didChangeSlider(value: Float) {
        guard let trackPlayer = player else { return }
        trackPlayer.volume = value
    }
    
    func didTapPlayPauseButton() {
        guard let trackPlayer = player else { return }
        if playerIsPlaying { trackPlayer.pause() }
        else { trackPlayer.play() }
    }
    
    func didTapNextButton() {
        if playerIsPlaying { player?.pause() }
        guard let index = currentTrackIndex else {
            // to do - handle error
            return
        }
        if index < numberOfTracks - 1 {
            currentTrackIndex! += 1
            player?.replaceCurrentItem(with: currentPlayingItem?.avPlayerItem)
            player?.play()
        }
        else { player?.play() }
    }
    
    func didTapPreviousButton() {
        if playerIsPlaying { player?.pause() }
        guard let index = currentTrackIndex else {
            // to do - handle error
            return
        }
        if index > 0 {
            currentTrackIndex! -= 1 // PR note - how else can I handle this?
            player?.replaceCurrentItem(with: currentPlayingItem?.avPlayerItem)
            player?.play()
        }
        else { player?.play() }
    }
    
}

// MARK: data source

extension PlaybackPresenter: PlayerDataSource {
    
    var songName: String? {
        return currentPlayingItem?.trackData.name
    }
    
    var subtitle: String? {
        return currentPlayingItem?.trackData.artist.name
    }
    
    var imageUrl: URL? {
        return URL(string: currentPlayingItem?.trackData.image ?? "")
    }
    
}

//MARK: getting data from view controllers

extension PlaybackPresenter {
    
    func songPlayer(modelType: PlayerInputData) {
        var playerTracks: [PlayerTrack] = []
        var onViewController: UIViewController?
        
        switch modelType {
        case .searchTrackItem(let viewController, let data):
            for searchTrackItem in data {
                playerTracks.append(searchTrackToPlayerTrack(searchTrackItem: searchTrackItem))
            }
            onViewController = viewController
        case .audioTrack(let viewController, let data, let albumImage):
            for audioTrack in data {
                playerTracks.append(audioTrackToPlayerTrack(audioTrack: audioTrack, albumImage: albumImage))
            }
            onViewController = viewController
        case .playlistTrackItem(let viewController, let data):
            for playlistTrack in data {
                playerTracks.append(playlistTrackItemToPlayerTrack(playlistTrackItem: playlistTrack))
            }
            onViewController = viewController
        }
        
        guard let viewController = onViewController else { return }
        playMultipleTracks(on: viewController, with: playerTracks)
    }
    
}

//MARK: - Private extensions -

//MARK: data conversion

private extension PlaybackPresenter {
    
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
