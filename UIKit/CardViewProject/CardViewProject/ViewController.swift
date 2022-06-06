//
//  ViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Simple Card View", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showSimpleCardViewContoller(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button1])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func showSimpleCardViewContoller(_ sender: UIButton) {
        let vc = SimpleCardViewController()
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(vc, animated: true)
    }
}

