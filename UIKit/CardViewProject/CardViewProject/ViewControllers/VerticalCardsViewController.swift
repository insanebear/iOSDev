//
//  VerticalCardsViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/07/08.
//

import UIKit

class VerticalCardsViewController: UICollectionViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, MyData>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MyData>
    
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = generateLayout()
        
        // cell registration
        self.collectionView.register(CardViewListCell.self, forCellWithReuseIdentifier: "\(CardViewListCell.self)")
        
        // set diffable data source
        dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardViewListCell.self)", for: indexPath) as? CardViewListCell else {
                return UICollectionViewCell()
            }
            let data = MyData.myDataList[indexPath.row]
            cell.configure(data: data)
            
            return cell
        })
        
        updateSnapshot()
        collectionView.dataSource = dataSource
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        config.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { indexPath, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalWidth(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(1.0))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                           subitems: [item])
            
            return NSCollectionLayoutSection(group: group)
        }, configuration: config)
        
        return layout
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(MyData.myDataList, toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
