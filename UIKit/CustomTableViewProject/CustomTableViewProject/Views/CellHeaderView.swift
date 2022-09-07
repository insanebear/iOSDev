//
//  CellHeaderView.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/07.
//

import UIKit

class CellHeaderView: UIView {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
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
        let diameter = rect.size.width-10
        let radius = diameter / 2
        let circle = CGRect(x: midPoint.x - radius, y: midPoint.y - radius, width: diameter, height: diameter)
        context.addEllipse(in: circle)
        context.fillEllipse(in: circle)
        context.strokePath()
    }
}
