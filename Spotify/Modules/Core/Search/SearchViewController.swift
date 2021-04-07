//
//  SearchViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class SearchViewController: DMViewController {

    //MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Private properties
    
    private var categories: [Category] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let group = DispatchGroup()
        group.enter()
        APICaller.shared.getAllCategories { allCategoriesResponse in
            self.categories = allCategoriesResponse.response.categories
            group.leave()
        } failure: { _ in
            group.leave()
            // to do - handle error
        }

        group.notify(queue: .main) {
            self.configureCollectionView()
        }
    }

}

//MARK: - Public extensions -

//MARK: - Collection view delegates

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.configureCell(category: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchCollectionReusableView.identifier, for: indexPath) as? SearchCollectionReusableView else { return UICollectionReusableView() }
        header.configureHeader()
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // to do - show details of selected genre
        //let genre = categories[indexPath.row]
    }
    
}

//MARK: - Search deletage

extension SearchViewController: SearchCollectionReusableViewDelegate {
    
    func searchDidChange(searchText: String) {
        // to do - handle search text
    }
    
}

//MARK: - Private extensions -

extension SearchViewController {
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { ( _ , _ ) -> NSCollectionLayoutSection? in
            return self.createCategoriesLayout()
        })
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension SearchViewController {
    
    private func createCategoriesLayout() -> NSCollectionLayoutSection {
        // Item
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        // Group
        let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 5, bottom: 7, trailing: 5)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = createHeaderLayout()
        
        return section
    }
    
    private func createHeaderLayout() -> [NSCollectionLayoutBoundarySupplementaryItem] {
        let supplementaryItemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementaryItemLayoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        supplementaryItem.pinToVisibleBounds = true
        return [supplementaryItem]
    }
    
}
