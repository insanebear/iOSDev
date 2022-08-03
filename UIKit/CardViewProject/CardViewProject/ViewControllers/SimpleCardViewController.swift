//
//  SimpleCardViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class SimpleCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let data = MyData.myDataList[0]
        
        let card = CardView(width: 200, ratio: 1.5, filmColor: .orange)
        card.configureResource(images: [data.image])
        card.configureText(title: data.title,
                               subtitle: data.author,
                               memo: data.memo)

        self.view.addSubview(card)

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}
