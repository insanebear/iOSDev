//
//  MyData.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class MyData {
    let image: UIImage?
    let text: String
    
    init(imageName: String, text: String) {
        self.image = UIImage(named: imageName)
        self.text = text
    }
}

#if DEBUG
extension MyData {
    static let myDataList: [MyData] = [
        MyData(imageName: "image1", text: "Image1"),
        MyData(imageName: "image2", text: "Image2"),
    ]
}
#endif
