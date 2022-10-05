//
//  TableViewController+DataSource.swift
//  SyncTabCollectionViewProject
//
//  Created by Jayde Jeong on 2022/10/05.
//

import UIKit

class TableViewDataSource: UITableViewDiffableDataSource<Int, Int> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Int>
    
    func update(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(1...50), toSection: 0)
        
        apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
