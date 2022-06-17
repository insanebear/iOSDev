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
    
    private lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle("Song list", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showSongListCollectionView(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var button4: UIButton = {
        let button = UIButton()
        button.setTitle("Tag List", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showTagListCollectionView(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var button5: UIButton = {
        let button = UIButton()
        button.setTitle("Tag Filter List", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showTagFilterListCollectionView(_:)), for: .touchUpInside)
        
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3, button4, button5])
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
        let vc = CompositionalLayoutCollectionViewController()
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(vc, animated: true)
    }
    
    @objc private func showSongListCollectionView(_ sender: UIButton) {
        let vc = SongListViewController()
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(vc, animated: true)
    }
    
    @objc private func showTagListCollectionView(_ sender: UIButton) {
        let vc = TagListViewController()
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(vc, animated: true)
    }
    
    @objc private func showTagFilterListCollectionView(_ sender: UIButton) {
        let vc = TagFilterViewController()
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
}

