//
//  CardCollectionViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardCollectionViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MyData>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MyData>
    
    static let headerElementKind = "header-element-kind"
    
    enum Section: Int, Hashable, CaseIterable {
        case horizontalScrollList
        case horizontalPageList
        
        var name: String {
            switch self {
            case .horizontalScrollList: return "Horizontal Scroll List"
            case .horizontalPageList: return "Horizontal Page List"
            }
        }
    }
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = generateLayout()
        configureDatasource()
        updateSnapshot()
        
        collectionView.dataSource = self.dataSource
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var section: NSCollectionLayoutSection!
            
            guard let sectionIndex = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionIndex {
            case .horizontalScrollList:
                section = self.generateSectionLayout(width: 200,
                                                     ratio: 1.5,
                                                     scrollBehavior: .continuous)
            case .horizontalPageList:
                section = self.generateSectionLayout(width: 200,
                                                     ratio: 1,
                                                     scrollBehavior: .groupPagingCentered)
            }
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        return layout
    }
    
    func generateSectionLayout(width: CGFloat, ratio: CGFloat, scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                          heightDimension: .absolute(width * ratio))
    
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollBehavior
        
        // header space
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: CardCollectionViewController.headerElementKind, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        return section
    }
        
}
