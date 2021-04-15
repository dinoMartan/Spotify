//
//  ModelConverter.swift
//  Spotify
//
//  Created by Dino Martan on 15/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import Foundation

final class ModelConverter {
    
    static func searchAlbumElementToNewRelesesItem(searchAlbumElement: SearchAlbumElement) -> NewReleasesItem {
        let artist = searchAlbumElement.artists.first
        let itemExternalUrl = ExternalUrls(spotify: artist?.externalUrls.spotify ?? "")
        let itemArtist = Artist(externalUrls: itemExternalUrl, href: artist!.href, id: artist!.id, name: artist?.name, type: artist?.type, uri: artist?.uri)
        let newReleasesItem = NewReleasesItem(
            albumType: searchAlbumElement.type,
            artists: [itemArtist],
            availableMarkets: nil,
            externalUrls: nil,
            href: nil,
            id: searchAlbumElement.id,
            images: [APIImage(height: nil, url: searchAlbumElement.images.first?.url ?? "", width: nil)],
            name: searchAlbumElement.name,
            type: searchAlbumElement.type,
            uri: searchAlbumElement.uri)
        return newReleasesItem
    }
    
    static func artistsTrackToSearchTrackItem(artistsTrack: ArtistsTrack) -> SearchTracksItem {
        let album = artistsTrack.album
        let albumOwner = album.artists.first
            
        let searchOwner = SearchOwner(externalUrls: SearchExternalUrls(spotify: albumOwner?.externalUrls.spotify ?? ""), href: albumOwner?.href ?? "", id: albumOwner?.id ?? "", name: albumOwner?.name, type: albumOwner?.type ?? "", uri: albumOwner?.uri ?? "", displayName: albumOwner?.name)
        let searchAlbumElement = SearchAlbumElement(
            albumType: album.type.rawValue,
            artists: [searchOwner],
            availableMarkets: nil,
            externalUrls: SearchExternalUrls(spotify: album.externalUrls.spotify),
            href: album.href,
            id: album.id,
            images: [SearchImage(height: nil, url: album.images.first?.url ?? "", width: nil)],
            name: album.name,
            releaseDate: album.releaseDate,
            releaseDatePrecision: album.releaseDate,
            totalTracks: album.totalTracks,
            type: album.type.rawValue,
            uri: album.uri
        )
    
        let searchTrackItem = SearchTracksItem(
            album: searchAlbumElement,
            artists: [searchOwner],
            availableMarkets: nil,
            discNumber: artistsTrack.discNumber,
            durationMS: artistsTrack.durationMS,
            explicit: artistsTrack.explicit,
            externalIDS: SearchExternalIDS(isrc: artistsTrack.externalIDS.isrc),
            externalUrls: SearchExternalUrls(spotify: artistsTrack.externalUrls.spotify),
            href: artistsTrack.href,
            id: artistsTrack.id,
            isLocal: artistsTrack.isLocal,
            name: artistsTrack.name,
            popularity: artistsTrack.popularity,
            previewURL: artistsTrack.previewURL,
            trackNumber: artistsTrack.trackNumber,
            type: artistsTrack.type.rawValue,
            uri: artistsTrack.uri
        )
        
        return searchTrackItem
    }
    
}
