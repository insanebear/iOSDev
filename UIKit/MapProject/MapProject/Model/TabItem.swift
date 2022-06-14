//
//  TabItem.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import UIKit

enum TabItem: String, CaseIterable {
    case mapKit = "MapKit"
    case nMapMaps = "NMapMaps"

    var viewController: UIViewController {
        switch self {
        case .mapKit:
            return MapViewController()
        case .nMapMaps:
            return NMapViewController()
        }
    }
    
    var image: UIImage {
        switch self {
        case .mapKit:
            return UIImage(systemName: "map")!
        case .nMapMaps:
            return UIImage(systemName: "map.circle")!
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .mapKit:
            return UIImage(systemName: "map.fill")!
        case .nMapMaps:
            return UIImage(systemName: "map.circle.fill")!
        }
    }
    
    var title: String {
        return self.rawValue.capitalized(with: nil)
    }
}
