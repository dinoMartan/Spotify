//
//  PlaybackTrackViewModel.swift
//  Spotify
//
//  Created by Dino Martan on 08/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation
import AVFoundation

struct PlayingItem {
    
    let trackData: PlayerTrack
    let avPlayerItem: AVPlayerItem
    
}

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
