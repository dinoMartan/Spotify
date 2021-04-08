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
    static let shared = PlaybackPresenter()
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    private var track: PlayerTrack?
    private var tracks: [PlayerTrack] = []
    let playerViewController = UIStoryboard.Storyboard.player.viewController as? PlayerViewController
    
    var currentTrack: PlayerTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if let player = self.playerQueue, !tracks.isEmpty {
            let item = player.currentItem
            let items = player.items()
            guard let index = items.firstIndex(where: {$0 == item}) else { return nil }
            return tracks[index]
        }
        return nil
    }
    
    func startTrackPlayback(from viewController: UIViewController, track: SearchTracksItem) {
        let playerTrack = searchTrackToPlayerTrack(searchTrackItem: track)
        
        guard let url = URL(string: playerTrack.previewUrl ?? "") else { return }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        self.track = playerTrack
        self.tracks = []
        playSingleTrack(viewController: viewController)
    }
    
    func startTrackPlayback(from viewController: UIViewController, track: AudioTrack, albumImage: String) {
        let playerTrack = audioTrackToPlayerTrack(audioTrack: track, albumImage: albumImage)
        
        guard let url = URL(string: playerTrack.previewUrl ?? "") else { return }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        self.track = playerTrack
        self.tracks = []
        playSingleTrack(viewController: viewController)
    }
    
    func startTrackPlayback(from viewController: UIViewController, track: PlaylistTrackItem) {
        let playerTrack = playlistTrackItemToPlayerTrack(playlistTrackItem: track)
        
        guard let url = URL(string: playerTrack.previewUrl ?? "") else { return }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        self.track = playerTrack
        self.tracks = []
        playSingleTrack(viewController: viewController)
    }
    
    func startMultipleTracksPlayback(from viewController: UIViewController, tracks: [AudioTrack], albumImage: String) {
        var playerTracks: [PlayerTrack] = []
        for audioTrack in tracks {
            playerTracks.append(audioTrackToPlayerTrack(audioTrack: audioTrack,albumImage: albumImage))
        }
        self.track = nil
        self.tracks = playerTracks
        
        playMultipleTracks(viewController: viewController)
    }
    
    func startMultipleTracksPlayback(from viewController: UIViewController, tracks: [PlaylistTrackItem]) {
        var playerTracks: [PlayerTrack] = []
        for playlistTrack in tracks {
            playerTracks.append(playlistTrackItemToPlayerTrack(playlistTrackItem: playlistTrack))
        }
        self.track = nil
        self.tracks = playerTracks
        playMultipleTracks(viewController: viewController)
    }
    
    private func playSingleTrack(viewController: UIViewController) {
        guard let playerViewController = UIStoryboard.Storyboard.player.viewController as? PlayerViewController else { return }
        //guard let playerViewController = UIStoryboard(name: "Player", bundle: nil).instantiateViewController(identifier: "playerNavigation") as? PlayerNavigationController else { return }
        playerViewController.dataSource = self
        playerViewController.deletate = self
        viewController.present(playerViewController, animated: true) { [unowned self] in
            player?.play()
        }
    }
    
    private func playMultipleTracks(viewController: UIViewController) {
        guard let playerViewController = UIStoryboard.Storyboard.player.viewController as? PlayerViewController else { return }
        //guard let playerViewController = UIStoryboard(name: "Player", bundle: nil).instantiateViewController(identifier: "playerNavigation") as? PlayerNavigationController else { return }
        
        let items: [AVPlayerItem] = tracks.compactMap({
            guard let url = URL(string: $0.previewUrl ?? "") else { return nil }
            return AVPlayerItem(url: url)
        })
        self.playerQueue = AVQueuePlayer(items: items)
        self.playerQueue?.volume = 0.5
        self.playerQueue?.play()
        
        playerViewController.dataSource = self
        playerViewController.deletate = self
        viewController.present(playerViewController, animated: true) { [unowned self] in
            //
        }
    }
    
    
    
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
        guard let player = player else { return }
        player.volume = value
        guard let playerQueue = playerQueue else { return }
        playerQueue.volume = value
    }
    
    func didTapPlayPauseButton() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapNextButton() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
            player?.play()
        }
        else if let player = playerQueue {
            player.advanceToNextItem()
            guard let playerVC = playerViewController else { return }
            playerVC.configureUI()
        }
    }
    
    func didTapPreviousButton() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
            player?.play()
        }
        
        else if let firstItem = playerQueue?.items().first {
            // Go to previous track
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0.5
            
            //guard let playerVC = playerViewController else { return }
            //playerVC.configureUI()
        }
    }
    
}
