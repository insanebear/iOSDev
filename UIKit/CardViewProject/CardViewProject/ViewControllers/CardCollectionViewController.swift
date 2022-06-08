//
//  CardCollectionViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = generateLayout()
        // Register cell classes
        self.collectionView!.register(CardViewCell.self, forCellWithReuseIdentifier: "\(CardViewCell.self)")

    }
    
    func generateLayout() -> UICollectionViewLayout {
        let width: CGFloat = 200
        let height = width * 1.5
        
        let size = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                         heightDimension: .absolute(height))

    
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    // MARK: DataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return MyData.myDataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardViewCell.self)", for: indexPath) as? CardViewCell else {
            return UICollectionViewCell()
        }
    
        // Configure the cell
        let data = MyData.myDataList[indexPath.row]
        cell.cardView.setContents(image: data.image, title: data.title, subtitle: data.author, memo: data.memo)
    
        return cell
    }

}
