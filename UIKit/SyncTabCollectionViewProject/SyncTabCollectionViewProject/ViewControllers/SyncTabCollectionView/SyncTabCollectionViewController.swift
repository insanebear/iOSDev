//
//  SyncTabTableViewController.swift
//  SyncTabCollectionViewProject
//
//  Created by Jayde Jeong on 2022/10/05.
//

import UIKit

class SyncTabCollectionViewController: UIViewController {
    static let itemCollectionViewHeaderElementKind = "header-element-kind"
    static let tabCollectionViewFooterElementKind = "footer-element-kind"

    var myData: [String] = []
    
    let colors: [UIColor] = [
        .systemRed, .systemGreen, .systemBlue,
        .systemPink, .systemYellow, .systemTeal,
    ]
    
    var sectionNum: Int = 10
    let tabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var itemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var itemDataSource: ItemDataSource!
   
    var tabCellHeight: CGFloat = 100
    var itemCellHeight: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        
        myData = (1...55).map { "Data: \($0)" }
        
        let tabCollectionViewLayout = generateTabCompositionalLayout()
        tabCollectionView.collectionViewLayout = tabCollectionViewLayout
        tabCollectionView.tag = 1
        self.view.addSubview(tabCollectionView)
        
        let itemCollectionViewLayout = generateItemCompositionalLayout()
        itemCollectionView.collectionViewLayout = itemCollectionViewLayout
        itemCollectionView.tag = 2
        configureDataSource()
        self.view.addSubview(self.itemCollectionView)
        
        setConstraints()
    }
    
    func configureDataSource() {
        
        /// tabCollectionView
        tabCollectionView.dataSource = self
        tabCollectionView.register(MyButtonCell.self, forCellWithReuseIdentifier: "\(MyButtonCell.self)")
        
        // Register supplementary footer
        tabCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: SyncTabCollectionViewController.tabCollectionViewFooterElementKind, withReuseIdentifier: "myFooterView")

        /// itemCollectionView
        itemCollectionView.register(MyNormalCell.self, forCellWithReuseIdentifier: "\(MyNormalCell.self)")
        itemDataSource = ItemDataSource(collectionView: itemCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let c = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MyNormalCell.self)", for: indexPath) as! MyNormalCell
            c.contentView.backgroundColor = self.colors[indexPath.item % self.colors.count]
            c.label.text = itemIdentifier
            return c
        })
        
        // Register supplementary header
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderReusableView> (elementKind: SyncTabCollectionViewController.itemCollectionViewHeaderElementKind) {(supplementaryView, string, indexPath) in
            
            supplementaryView.backgroundColor = .lightGray
            supplementaryView.layer.borderColor = UIColor.black.cgColor
            supplementaryView.layer.borderWidth = 1.0
        }
        itemDataSource.supplementaryViewProvider = { (view, kind, indexPath) in
            
            let section = self.itemDataSource.snapshot().sectionIdentifiers[indexPath.section]

            let header = self.itemCollectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            header.label.text = "Section \(String(describing: section + 1))"
            
            return header
        }
        itemCollectionView.dataSource = itemDataSource
        itemDataSource.update(sectionNum: sectionNum, data: myData)
        
    }
    
}
