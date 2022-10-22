//
//  SyncTabTableViewController+DataSource.swift
//  SyncTabCollectionViewProject
//
//  Created by Jayde Jeong on 2022/10/05.
//

import UIKit

/// for itemCollectionView
class ItemDataSource: UICollectionViewDiffableDataSource<Int, String> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func update(anmiatingDifference: Bool = true, sectionNum: Int, data: [String]) {
        var snapshot = Snapshot()
        snapshot.appendSections(Array(0..<sectionNum))

        var start = 0
        
        for section in 0..<sectionNum {
            let count = section + 1
            let end = start + count
            snapshot.appendItems(Array(data[start..<end]), toSection: section)

            start += count
        }

        apply(snapshot, animatingDifferences: anmiatingDifference)
    }
}

/// for tabCollectionView
extension SyncTabCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MyButtonCell.self)", for: indexPath) as! MyButtonCell
        
        cell.contentView.backgroundColor = colors[indexPath.item % colors.count]
        cell.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(handleTapButtonCell(_:)))
        )
        cell.label.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                          withReuseIdentifier: "myFooterView",
                                                                          for: indexPath)

        return sectionView
    }

    @objc func handleTapButtonCell(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? MyButtonCell,
              let sectionText = cell.label.text,
              let sectionNum = Int(sectionText)
        else {
            return
        }
        
        // header offset attribute
        if let attributes = itemCollectionView.layoutAttributesForSupplementaryElement(ofKind: SyncTabCollectionViewController.itemCollectionViewHeaderElementKind,
                                                                                       at: IndexPath(item: 0, section: sectionNum-1)) {
            let offsetY = attributes.frame.origin.y - itemCollectionView.contentInset.top
            itemCollectionView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
        }
    }
}
