//
//  ExtraInfoView.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/07.
//

import UIKit

class ExtraInfoView: UIView {
    
    var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.sizeToFit()
        
        label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
//        guard let context = UIGraphicsGetCurrentContext() else { return }
        
//        let midPoint = CGPoint(x: rect.size.width/2, y: rect.size.height/2)
        
        // rectangle
//        let width: CGFloat = 200
//        let height: CGFloat = 100
//        let rectangle = CGRect(x: midPoint.x - 100, y: midPoint.y - 50, width: width, height: height)
//        context.setFillColor(UIColor.clear.cgColor)
//        context.addRect(rectangle)
//        context.fill(rectangle)
//        context.stroke(rect, width: 1)
    }
}
