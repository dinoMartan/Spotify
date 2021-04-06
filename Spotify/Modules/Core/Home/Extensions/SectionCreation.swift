//
//  SectionCreation.swift
//  Spotify
//
//  Created by Dino Martan on 05/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

extension HomeViewController {
    
    func createNewReleasesSection() -> NSCollectionLayoutSection {
        // Item
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        let verticalGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupLayoutSize, subitem: item, count: 3)
        
        let horizontalGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(390))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupLayoutSize, subitem: verticalGroup, count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    func createFeaturedPlaylistsSection() -> NSCollectionLayoutSection {
        // Item
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        let verticalGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupLayoutSize, subitem: item, count: 2)
        
        let horizontalGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .absolute(400))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupLayoutSize, subitem: verticalGroup, count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func createRecommendedTracksSection() -> NSCollectionLayoutSection {
        // Item
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        let verticalGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupLayoutSize, subitem: item, count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: verticalGroup)
        
        return section
    }
    
    func createDefaultSection() -> NSCollectionLayoutSection {
        // Item
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        // Group
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupLayoutSize, subitem: item, count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}
