//
//  CellLeadingView.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/07.
//

import UIKit

class CellLeadingView: UIView {
    
    var numberLabel: UILabel!
    let offset: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel = UILabel()
        numberLabel.textColor = .white
        numberLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -offset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let midPoint = CGPoint(x: rect.size.width/2, y: rect.size.height/2)
        
        // line
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setFillColor(UIColor.gray.cgColor)
        
        let startingPoint = CGPoint(x: rect.size.width/2, y: 0)
        let endingPoint = CGPoint(x: rect.size.width/2, y: rect.size.height)
        context.move(to: startingPoint)
        context.addLine(to: endingPoint)
        context.strokePath()
        
        // circle
        let diameter = rect.size.width-25
        let radius = diameter / 2
        let circle = CGRect(x: midPoint.x - radius, y: midPoint.y - radius - offset, width: diameter, height: diameter)
        context.addEllipse(in: circle)
        context.fillEllipse(in: circle)
        context.strokePath()
    }
}