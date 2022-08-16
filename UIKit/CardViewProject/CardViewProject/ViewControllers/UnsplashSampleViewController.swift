//
//  UnsplashSampleViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/08/16.
//

import UIKit

class UnsplashSampleViewController: UIViewController {
    let searchBar = UISearchBar()
    var collectionView: UICollectionView!
    
    let imageQuery = ImageQuery()
    var imageData: [Image] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .darkGray
        
        setupSearchBar()
        setupCollectionView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        
        searchBar.sizeToFit()
        searchBar.placeholder = "Search photos"
        searchBar.searchBarStyle = .minimal
        searchBar.isTranslucent = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let searchBarTextField = searchBar.searchTextField
        searchBarTextField.textColor = .white
        
        self.view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: "\(ImageViewCell.self)")
        collectionView.dataSource = self
        collectionView.backgroundColor = .darkGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func generateLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

// MARK: - UICollectionViewDataSource

extension UnsplashSampleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageViewCell.self)", for: indexPath) as? ImageViewCell else {
            return UICollectionViewCell()
        }
        
        // use 'regular' size image
        let regularSizeImageUrl = imageData[indexPath.row].urls.regular
        
        if let url = URL(string: regularSizeImageUrl) {
            cell.configure(url: url)
        }
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension UnsplashSampleViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchQuery = searchBar.text else {
            return
        }
        
        imageQuery.fetchData(query: searchQuery) { imageResults in
            DispatchQueue.main.async {
                // get image results and refresh the collection view
                self.imageData = imageResults
                self.collectionView.reloadData()
            }
        }
    }
}
