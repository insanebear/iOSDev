//
//  CompositionalLayoutCollectionViewController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/05/25.
//

import UIKit

class CompositionalLayoutCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(TextCell.self, forCellWithReuseIdentifier: "\(TextCell.self)")

    }

    // MARK: DataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TextCell.self)", for: indexPath) as? TextCell else {
            fatalError()
        }

        // Configure the cell
        cell.label.text = "\(indexPath.row+1)"
        cell.backgroundColor = .systemGreen
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1

        return cell
    }
}
