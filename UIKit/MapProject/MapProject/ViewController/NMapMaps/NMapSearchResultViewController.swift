//
//  NMapSearchResultViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/14.
//

import UIKit

class NMapSearchResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
