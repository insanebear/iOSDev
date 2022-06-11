//
//  TabItem.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import UIKit

enum TabItem: String, CaseIterable {
    case mapKit = "MapKit"
    
    var viewController: UIViewController {
        switch self {
        case .mapKit:
            return MapViewController()
        }
    }
    
    var image: UIImage {
        switch self {
        case .mapKit:
            return UIImage(systemName: "map")!
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .mapKit:
            return UIImage(systemName: "map.fill")!
        }
    }
    
    var title: String {
        return self.rawValue.capitalized(with: nil)
    }
}
