//
//  TagFilterViewController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/17.
//

import UIKit

class TagFilterViewController: UIViewController {

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
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Tag Filter"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.collectionViewLayout = generateLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        setupDataSource()
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

extension TagFilterViewController: UICollectionViewDataSource {
    func setupDataSource() {
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "\(TagCell.self)")
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: "\(EmojiCell.self)")
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Section.tagList.rawValue {
            return sampleTags.count
        } else {
            return Emoji.emojiList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Section.tagList.rawValue {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TagCell.self)", for: indexPath) as? TagCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(text: sampleTags[indexPath.row])
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(EmojiCell.self)", for: indexPath) as? EmojiCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(emoji: Emoji.emojiList[indexPath.row])
            
            return cell
        }
    }
    
}
