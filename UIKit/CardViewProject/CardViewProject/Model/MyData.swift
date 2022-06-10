//
//  MyData.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

struct MyData: Hashable {
    let image: UIImage?
    let title: String
    let author: String
    let memo: String
    
    init(imageName: String, title: String, author: String, memo: String) {
        self.image = UIImage(named: imageName)
        self.title = title
        self.author = author
        self.memo = memo
    }
}

#if DEBUG
extension MyData {
    static let myDataList: [MyData] = [
        MyData(imageName: "image1", title: "Image1", author: "Jayde", memo: "서울숲"),
        MyData(imageName: "image2", title: "Image2", author: "Jayde", memo: "서울숲"),
        MyData(imageName: "image1", title: "Image3", author: "Jayde", memo: "서울숲"),
        MyData(imageName: "image2", title: "Image4", author: "Jayde", memo: "서울숲"),
    ]
    static let myDataList2: [MyData] = [
        MyData(imageName: "image3", title: "Image1", author: "Jayde", memo: "공원"),
        MyData(imageName: "image4", title: "Image2", author: "Jayde", memo: "공원"),
        MyData(imageName: "image3", title: "Image3", author: "Jayde", memo: "공원"),
        MyData(imageName: "image4", title: "Image4", author: "Jayde", memo: "공원"),
        MyData(imageName: "image3", title: "Image5", author: "Jayde", memo: "공원"),
        MyData(imageName: "image4", title: "Image6", author: "Jayde", memo: "공원"),
        MyData(imageName: "image3", title: "Image7", author: "Jayde", memo: "공원"),
        MyData(imageName: "image4", title: "Image8", author: "Jayde", memo: "공원"),
    ]
}
#endif
