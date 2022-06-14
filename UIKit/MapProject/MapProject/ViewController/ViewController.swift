//
//  ViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewControllers()
    }
    
    func loadViewControllers() {
        let tabItems: [TabItem] = [.mapKit, .nMapMaps]
        var controllers: [UIViewController] = []
        
        // create each view controller for a tab
        for i in 0 ..< tabItems.count {
            let item = tabItems[i]
            let vc = item.viewController
            vc.tabBarItem = UITabBarItem(title: item.title,
                                         image: item.image,
                                         selectedImage: item.selectedImage)
            vc.title = item.title
            controllers.append(vc)
        }
        
        // register view controllers as UINavigation view controllers
        self.viewControllers = controllers.map { controller in
            return UINavigationController(rootViewController: controller)
        }
    }
}

