//
//  MainViewController.swift
//  TableViewProject
//
//  Created by Jayde Jeong on 2022/05/22.
//

import UIKit

class MainViewController: UIViewController {
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("UIViewController", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showViewController2(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("UITableViewController", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(showTableViewController(_:)), for: .touchUpInside)
        
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button1, button2])
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

    @objc private func showViewController2(_ sender: UIButton) {
        let vc = ViewController()
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(vc, animated: true)
    }
    @objc private func showTableViewController(_ sender: UIButton) {
        let vc = TableViewController()
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(vc, animated: true)
    }
}

