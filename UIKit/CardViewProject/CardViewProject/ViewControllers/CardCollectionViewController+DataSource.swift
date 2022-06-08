//
//  CardCollectionViewController+DataSource.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/08.
//

import UIKit

extension CardCollectionViewController {
    func configureDatasource() {
        // Register cell classes
        self.collectionView.register(CardViewListCell.self, forCellWithReuseIdentifier: "\(CardViewListCell.self)")
        self.collectionView.register(CardViewPageCell.self, forCellWithReuseIdentifier: "\(CardViewPageCell.self)")

        // Register supplementary header
        let headerRegistration = UICollectionView.SupplementaryRegistration<CardCollectionViewHeaderView>(elementKind: CardCollectionViewController.headerElementKind) { supplementaryView, elementKind, indexPath in
            supplementaryView.label.text = Section(rawValue: indexPath.section)?.name
        }
        
        // Set diffable data source
        dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            var cell = UICollectionViewCell()
            switch indexPath.section {
            case Section.horizontalScrollList.rawValue:
                if let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardViewListCell.self)", for: indexPath) as? CardViewListCell {
                    let data = MyData.myDataList[indexPath.row]
                    listCell.configure(data: data)
                    cell = listCell
                }
            case Section.horizontalPageList.rawValue:
                if let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardViewPageCell.self)", for: indexPath) as? CardViewPageCell {
                    let data = MyData.myDataList2[indexPath.row]
                    pageCell.configure(data: data)
                    cell = pageCell
                }
            default:
                cell = UICollectionViewCell()
            }
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.horizontalScrollList, .horizontalPageList])
        snapshot.appendItems(MyData.myDataList, toSection: .horizontalScrollList)
        snapshot.appendItems(MyData.myDataList2, toSection: .horizontalPageList)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return MyData.myDataList.count
    }
}
