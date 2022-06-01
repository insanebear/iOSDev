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
    
    static let loadingElementKind = "loading-element-kind"
    
    var dataSource: DataSource!
    var isLoading = false
    
    var searchResults: [Song] = []
    var songList: [Song] = []

    init() {
        super.init(collectionViewLayout: SongListViewController.generateLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Search songs and fill out the search results first
        searchSong(searchTerm: "Younha")
        
        loadMoreData()
        configureDatasource()
        collectionView.dataSource = self.dataSource
        
    }
    
    static func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        // indicator footer
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let indicatorSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: SongListViewController.loadingElementKind, alignment: .bottom)
        
        section.boundarySupplementaryItems = [indicatorSupplementary]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

    // MARK: DataSource
    
    func configureDatasource() {
        // Register cell classes
        collectionView.register(SongCell.self, forCellWithReuseIdentifier: "\(SongCell.self)")
        
        // Register footer supplementary view
        let indicatorRegistration = UICollectionView.SupplementaryRegistration<LoadingCell> (elementKind: SongListViewController.loadingElementKind) { supplementaryView, elementKind, indexPath in
            
            if self.isLoading {
                supplementaryView.indicator.startAnimating()
            } else {
                supplementaryView.indicator.stopAnimating()
            }
        }
        
        // Set diffable data source
        dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SongCell.self)", for: indexPath) as? SongCell else {
                fatalError("Cannot find SongCell")
            }
        
            // Configure the cell
            cell.configure(song: itemIdentifier)
        
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: indicatorRegistration, for: index)
        }
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(self.songList, toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == SongListViewController.loadingElementKind {
            guard let view = view as? LoadingCell else {
                fatalError()
            }
            view.indicator.stopAnimating()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.songList.count - 10 && !self.isLoading {
            loadMoreData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = SongDetailViewController(song: songList[indexPath.row])
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SongListViewController {
    // MARK: Search
    func searchSong(searchTerm: String) {
        let musicQuery = MusicQuery()
        
        musicQuery.searchMusic(searchTerm: searchTerm) { songs in
            self.searchResults = songs
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                sleep(2)
                
                let start = self.songList.count
                let end = start + 30
                
                if end < self.searchResults.count {
                    self.songList.append(contentsOf: (start...end).map { self.searchResults[$0] })
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.updateSnapshot()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.updateSnapshot()
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}
