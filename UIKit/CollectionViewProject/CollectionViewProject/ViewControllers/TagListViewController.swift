//
//  TagListViewController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/10.
//

import UIKit

class TagListViewController: UIViewController {

    let sampleTags: [String] = [
        "바닷가", "산", "경치좋은", "요즘뜨는", "맛있는", "볼거리가_많은",
        "색다른_경험", "온가족여행", "우정여행", "커플여행", "혼자여행"
    ]
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let tagView = TagView(frame: .zero)
        tagView.setText(with: "태그태그태그태그태그태그")
        self.view.addSubview(tagView)
        
        collectionView.collectionViewLayout = generateLayout()
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "\(TagCell.self)")
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/3),

            tagView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50),
            tagView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])

    }
    
    func generateLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                          heightDimension: .estimated(40))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: size.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension TagListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sampleTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TagCell.self)", for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(text: sampleTags[indexPath.row])
        
        return cell
    }
    
}
