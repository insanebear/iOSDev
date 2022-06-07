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
        
        let card = CardView(width: 200, ratio: 1.5, filmColor: .orange)
        card.setContents(image: MyData.myDataList[0].image)
        card.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(card)

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}
