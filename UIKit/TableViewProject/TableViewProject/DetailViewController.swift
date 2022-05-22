//
//  DetailViewController.swift
//  TableViewProject
//
//  Created by Jayde Jeong on 2022/05/23.
//

import UIKit

class DetailViewController: UIViewController {
    var number: Int
    
    init(number: Int) {
        self.number = number
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "You selected \(number)-th row"
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
