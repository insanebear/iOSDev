//
//  SongListViewController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/05/31.
//

import UIKit

class SongListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Song>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Song>
    
    var dataSource: DataSource!
    
    var searchResults: [Song] = []
    
    init() {
        super.init(collectionViewLayout: SongListViewController.generateLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatasource()
        collectionView.dataSource = self.dataSource
        
        searchSong(searchTerm: "Younha")
    }
    
    static func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

    // MARK: DataSource
    
    func configureDatasource() {
        // Register cell classes
        collectionView.register(SongCell.self, forCellWithReuseIdentifier: "\(SongCell.self)")
        
        // Set diffable data source
        dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SongCell.self)", for: indexPath) as? SongCell else {
                fatalError("Cannot find SongCell")
            }
        
            // Configure the cell
            cell.configure(song: self.searchResults[indexPath.row])
        
            return cell
        })
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(self.searchResults, toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SongListViewController {
    // MARK: Search
    func searchSong(searchTerm: String) {
        let musicQuery = MusicQuery()
        
        musicQuery.searchMusic(searchTerm: searchTerm) { songs in
            DispatchQueue.main.async {
                self.searchResults = songs
                self.updateSnapshot()
            }
        }
    }
}
