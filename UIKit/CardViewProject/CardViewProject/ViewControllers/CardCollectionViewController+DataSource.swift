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
        self.collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: "\(CardViewCell.self)")
        
        // Register supplementary header
        let headerRegistration = UICollectionView.SupplementaryRegistration<CardCollectionViewHeaderView>(elementKind: CardCollectionViewController.headerElementKind) { supplementaryView, elementKind, indexPath in
            supplementaryView.label.text = Section(rawValue: indexPath.section)?.name
        }
        
        // Set diffable data source
        dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardViewCell.self)", for: indexPath) as? CardViewCell else {
                return UICollectionViewCell()
            }
        
            // Configure the cell
            if indexPath.section == Section.horizontalScrollList.rawValue {
                let data = MyData.myDataList[indexPath.row]
                cell.configure(data: data)
            } else {
                let data = MyData.myDataList2[indexPath.row]
                cell.configure(data: data)
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
