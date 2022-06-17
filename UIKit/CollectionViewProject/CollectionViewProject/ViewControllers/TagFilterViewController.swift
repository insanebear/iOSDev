//
//  TagFilterViewController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/17.
//

import UIKit

class TagFilterViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    let sampleTags: [String] = [
        "Fruit", "Face", "Activity",
    ]
    
    enum Section: Int, CaseIterable {
        case tagList
        case itemList
        
        var name: String {
            switch self {
            case .tagList:
                return "Tags"
            case .itemList:
                return "Items"
            }
        }
    }
    let emojisController = EmojisController()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Tag Filter"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.delegate = self
        collectionView.collectionViewLayout = generateLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        configureDataSource()
        performQuery(with: nil)
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    func generateLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionLayoutKind = Section(rawValue: sectionIndex) else { return nil }
            
            switch sectionLayoutKind {
            case .tagList:
                // Tag Section Layout
                let size = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                                  heightDimension: .estimated(40))
                
                let item = NSCollectionLayoutItem(layoutSize: size)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: size.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(5)
                
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .itemList:
                // Item List Section Layout
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
                
                let item = NSCollectionLayoutItem(layoutSize: size)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        return layout
    }
}

extension TagFilterViewController {
    func configureDataSource() {
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "\(TagCell.self)")
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: "\(EmojiCell.self)")
        
        self.dataSource = DataSource(collectionView: self.collectionView,
                                     cellProvider: { collectionView, indexPath, itemIdentifier in
            
            if indexPath.section == Section.tagList.rawValue {
                // Section: Tag List
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TagCell.self)",
                                                                    for: indexPath) as? TagCell,
                      let tag = itemIdentifier as? String else {
                    return UICollectionViewCell()
                }
                
                cell.configure(text: tag, isTappable: false)
                return cell
                
            } else {
                // Section: Item List
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(EmojiCell.self)",
                                                                  for: indexPath) as? EmojiCell,
                    let emoji = itemIdentifier as? EmojisController.Emoji else {
                    return UICollectionViewCell()
                }
                
                cell.configure(emoji: emoji)
                return cell
                
            }
        })
        
        self.collectionView.dataSource = self.dataSource
    }
    
    func performQuery(with filter: String?) {
        let items = emojisController.filteredEmojis(with: filter) // get filtered emojis
        
        var snapshot = Snapshot()
        snapshot.appendSections([Section.tagList, Section.itemList])
        snapshot.appendItems(sampleTags, toSection: .tagList)
        snapshot.appendItems(items, toSection: .itemList)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension TagFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // When a tag in Tag List section is selected,
        if indexPath.section == Section.tagList.rawValue {
            performQuery(with: sampleTags[indexPath.row])
        }
    }
}
