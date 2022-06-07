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
        
        let card = CardView(frame: .zero)
        card.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(card)

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            card.widthAnchor.constraint(equalToConstant: 200),
            card.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
