//
//  CardResourceScrollView.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/28.
//

import UIKit

class CardResourceScrollView: UIScrollView {
    var width: CGFloat = 0
    var ratio: CGFloat = 0

    var data = MyData2.myDataList[0]
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // scroll view
        self.isPagingEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(width: CGFloat, ratio: CGFloat) {
        self.init(frame: .zero)
        self.width = width
        self.ratio = ratio
        
        // stack view
        setContents()
        self.addSubview(stackView)
        
        setAlignment()
    }

    func setAlignment() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: self.width),
            self.heightAnchor.constraint(equalToConstant: self.width * self.ratio),

            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func setContents() {
        // create cards and set data in the stack view
//        for data in dataList {
//            let cardView = CardView(width: self.width, ratio: self.ratio, filmType: .gradient, filmColor: .black, overlayOpacity: 0.5)
//            cardView.setContents(image: data.image, title: data.title, subtitle: data.author, memo: data.memo)
//
//            stackView.addArrangedSubview(cardView)
//        }
        
        for image in data.images {
            if let image = image {
                let imageView = UIImageView(image: image)
                stackView.addArrangedSubview(imageView)
            }
        }
    }
}
