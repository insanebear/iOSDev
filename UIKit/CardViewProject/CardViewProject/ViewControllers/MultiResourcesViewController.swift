//
//  MultiResourcesViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/28.
//

import UIKit

class MultiResourcesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let data = MyData2.myDataList[0]
        
        let cardView = CardView(data: data, width: 300, ratio: 0.5)
        cardView.configureResource(images: data.images)
        cardView.configureText(title: data.title,
                               subtitle: data.author,
                               memo: data.memo)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
