//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("FlowLayout", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showFlowLayoutCollectionView(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("CompositionalLayout", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showCompositionalLayoutCollectionView(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button1, button2])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func showFlowLayoutCollectionView(_ sender: UIButton) {
        let layout = generateFlowLayout()
        let vc = FlowLayoutCollectionViewController(collectionViewLayout: layout)
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(vc, animated: true)
    }
    @objc private func showCompositionalLayoutCollectionView(_ sender: UIButton) {
        let layout = generateCompositionalLayout()
        let vc = CompositionalLayoutCollectionViewController(collectionViewLayout: layout)
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(vc, animated: true)
    }
    
    private func generateFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width/3-2, height: view.frame.height/5)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 1
        
        return layout
    }
    
    private func generateCompositionalLayout() -> UICollectionViewLayout {
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
    
}

