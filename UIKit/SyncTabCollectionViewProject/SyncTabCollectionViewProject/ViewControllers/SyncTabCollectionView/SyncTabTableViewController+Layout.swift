//
//  SyncTabTableViewController+Layout.swift
//  SyncTabCollectionViewProject
//
//  Created by Jayde Jeong on 2022/10/21.
//

import UIKit

extension SyncTabCollectionViewController {
    func setConstraints() {
        let g = view.safeAreaLayoutGuide
        
        tabCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tabCollectionView.topAnchor.constraint(equalTo: g.topAnchor),
            tabCollectionView.bottomAnchor.constraint(equalTo: g.bottomAnchor),
            tabCollectionView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
            tabCollectionView.widthAnchor.constraint(equalToConstant: 100.0),
            
            itemCollectionView.topAnchor.constraint(equalTo: g.topAnchor),
            itemCollectionView.leadingAnchor.constraint(equalTo: tabCollectionView.trailingAnchor),
            itemCollectionView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
            itemCollectionView.bottomAnchor.constraint(equalTo: g.bottomAnchor)
            
        ])
    }
    
    func generateTabCompositionalLayout() -> UICollectionViewLayout {
        /// CollectionView Compositional layout for tabs
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // content
            let contentSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .absolute(self!.tabCellHeight))
            
            let contentItem = NSCollectionLayoutItem(layoutSize: contentSize)
            contentItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self!.tabCellHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [contentItem])
            
            
            let section = NSCollectionLayoutSection(group: group)

            // !!!: Review the constant values
            
            // footer
            let screenHeight = UIScreen.main.bounds.height
            let naviBarHeight = self?.navigationController?.navigationBar.frame.size.height
            let blankHeight = screenHeight - self!.tabCellHeight * 2 - naviBarHeight!

            let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(blankHeight))
            let footerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: SyncTabCollectionViewController.tabCollectionViewFooterElementKind, alignment: .bottom)
            
            section.boundarySupplementaryItems = [footerSupplementary]
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func generateItemCompositionalLayout() -> UICollectionViewLayout {
        /// CollectionView Compositional layout for items
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // content
            let contentSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .absolute(self!.itemCellHeight))
            
            let contentItem = NSCollectionLayoutItem(layoutSize: contentSize)
            contentItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self!.itemCellHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [contentItem])
            
            let section = NSCollectionLayoutSection(group: group)
            
            // header
            let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: SyncTabCollectionViewController.itemCollectionViewHeaderElementKind, alignment: .top)
            
            section.boundarySupplementaryItems = [headerSupplementary]
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider, configuration: config)
        return layout
    }
}
