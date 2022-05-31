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
    
    static let headerElementKind = "header-element-kind"
    static let footerElementKind = "footer-element-kind"

    enum Section: Int {
        case first
        case second
        
        var name: String {
            switch self {
            case .first: return "First section"
            case .second: return "Second section"
            }
        }
    }

    init() {
        super.init(collectionViewLayout: CompositionalLayoutCollectionViewController.generateCompositionalLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure data source
        configureDatasource()
        
        // Update initial snapshot
        updateSnapshot()
        
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
        
        // Keeping space for section header footer in layout
        let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: CompositionalLayoutCollectionViewController.headerElementKind, alignment: .top)
        let footerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementarySize, elementKind: CompositionalLayoutCollectionViewController.footerElementKind, alignment: .bottom)

        section.boundarySupplementaryItems = [headerSupplementary, footerSupplementary]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // MARK: DataSource
    
    func configureDatasource() {
        // Register cell classes
        self.collectionView.register(TextCell.self, forCellWithReuseIdentifier: "\(TextCell.self)")
        
        // Register supplementary header
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderReusableView> (elementKind: CompositionalLayoutCollectionViewController.headerElementKind) {(supplementaryView, string, indexPath) in
            
            supplementaryView.label.text = "\(String(describing: Section(rawValue: indexPath.section)?.name ?? ""))"
            supplementaryView.backgroundColor = .lightGray
            supplementaryView.layer.borderColor = UIColor.black.cgColor
            supplementaryView.layer.borderWidth = 1.0
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration<FooterReusableView> (elementKind: CompositionalLayoutCollectionViewController.footerElementKind) { supplementaryView,elementKind,indexPath in
            
        }
        
        // Set diffable data source
        dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TextCell.self)", for: indexPath) as? TextCell else {
                fatalError()
            }
            
            // Configure the cell (set value)
            cell.configure(item: itemIdentifier)
            
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            if kind == CompositionalLayoutCollectionViewController.headerElementKind {
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
            }
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
        }
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.first, Section.second])
        snapshot.appendItems(Array(0..<31), toSection: Section.first)
        snapshot.appendItems(Array(31..<61), toSection: Section.second)
        
        dataSource.apply(snapshot, animatingDifferences: false) // apply snapshot to data source
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }
}
