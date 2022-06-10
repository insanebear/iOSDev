//
//  CardCollectionViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit
import Combine

class CardCollectionViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MyData>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MyData>
    
    static let headerElementKind = "header-element-kind"
    static let footerElementKind = "footer-element-kind"
    
    let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    
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
                section = self.generateHorizontalScrollListLayout(width: 200,
                                                                  ratio: 1.5,
                                                                  scrollBehavior: .continuous)
            case .horizontalPageList:
                section = self.generateHorizontalPageListLayout(width: layoutEnvironment.container.effectiveContentSize.width,
                                                                ratio: 0.75,
                                                                scrollBehavior: .groupPagingCentered,
                                                                sectionIndex: sectionIndex.rawValue)
            }
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        return layout
    }
    
    func generateHorizontalScrollListLayout(width: CGFloat, ratio: CGFloat, scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                          heightDimension: .absolute(width * ratio))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitems: [item])
        // header space
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: CardCollectionViewController.headerElementKind, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollBehavior
        section.boundarySupplementaryItems = [headerSupplementary]
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        return section
    }
    
    func generateHorizontalPageListLayout(width: CGFloat, ratio: CGFloat, scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior, sectionIndex: Int) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                          heightDimension: .absolute(width * ratio))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitems: [item])
        
        // Supplementary spaces
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: CardCollectionViewController.headerElementKind, alignment: .top)
        let footerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: CardCollectionViewController.footerElementKind, alignment: .bottom)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollBehavior
        section.boundarySupplementaryItems = [headerSupplementary, footerSupplementary]
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) -> Void in
            let currentPage = Int(offset.x / size.widthDimension.dimension)
            self.pagingInfoSubject.send(PagingInfo(sectionIndex: sectionIndex, currentPage: currentPage))
        }
        
        return section
    }
}
