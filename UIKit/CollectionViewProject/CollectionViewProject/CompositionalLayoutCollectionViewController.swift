//
//  CompositionalLayoutCollectionViewController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/05/25.
//

import UIKit

class CompositionalLayoutCollectionViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Int>
    
    var dataSource: DataSource!
    
    enum Section: String {
        case first
        case second
    }

    init() {
        super.init(collectionViewLayout: CompositionalLayoutCollectionViewController.generateCompositionalLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(TextCell.self, forCellWithReuseIdentifier: "\(TextCell.self)")
        
        // Set diffable data source
        dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TextCell.self)", for: indexPath) as? TextCell else {
                fatalError()
            }

            // Configure the cell (set value)
            cell.configure(item: itemIdentifier)

            return cell
        })
        
        // Update initial snapshot
        var snapshot = Snapshot()
        snapshot.appendSections([Section.first, Section.second])
        snapshot.appendItems(Array(0..<31), toSection: Section.first)
        snapshot.appendItems(Array(31..<61), toSection: Section.second)
        
        dataSource.apply(snapshot, animatingDifferences: false) // apply snapshot to data source

        // Set data source as collection view's data source
        collectionView.dataSource = self.dataSource

    }
    
    static func generateCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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
}
