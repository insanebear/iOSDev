//
//  ButtonCardViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/08/03.
//

import UIKit

class ButtonCardViewController: UIViewController {
    private var cardView: CardView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let data = MyData.myDataList[0]
        
        cardView = CardView(data: data, width: 300, ratio: 1.5)
        cardView.configureResource(images: [data.image])
        cardView.configureText(title: data.title,
                               subtitle: data.author,
                               memo: data.memo)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        setupCardIconViews()
        
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupCardIconViews() {
        
        if let likeIcon = UIImage(systemName: "heart.fill"),
           let bookmarkIcon = UIImage(systemName: "bookmark.fill") {

            let likesIconView = CardIconView()
            let bookmarkIconView = CardIconView()

            likesIconView.setIcon(image: likeIcon)
            likesIconView.setTitle(title: "Likes")
    
            bookmarkIconView.setIcon(image: bookmarkIcon)
            bookmarkIconView.setTitle(title: "Saved")
            
            let cardIconsView = CardIconsView()
            cardIconsView.setCardIconViews(iconViews: [likesIconView, bookmarkIconView])
            
            cardView.setupIconsView(cardIconsView: cardIconsView)
        }
    }
}
