//
//  SwipeableCardViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/15.
//

import UIKit

class SwipeableCardViewController: UIViewController {
    var cardList: [CardView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // for a range check
        let square = UIView()
        square.backgroundColor = .red
        square.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(square)
        
        createCards()
        
        NSLayoutConstraint.activate([
            square.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            square.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            square.widthAnchor.constraint(equalToConstant: self.view.frame.width/2),
            square.heightAnchor.constraint(equalToConstant: self.view.frame.height)
        ])
    }
    
    func createCards() {
        for data in MyData.myDataList {
            let card = CardView(width: 250, ratio: 1.5, isSwipeable: true)
            card.setContents(image: data.image,
                             title: data.title,
                             subtitle: data.author,
                             memo: data.memo)
            cardList.append(card)
            self.view.addSubview(card)
            NSLayoutConstraint.activate([
                card.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                card.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
    }
}
