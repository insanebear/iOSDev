//
//  ViewController.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/06.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MyCell.self, forCellReuseIdentifier: "\(MyCell.self)")
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyCell.self)", for: indexPath) as? MyCell else {
            return UITableViewCell()
        }
        
        let num = indexPath.row + 1
        cell.configure(text: String(num))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

