//
//  CellLeadingView.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/07.
//

import UIKit

class CellLeadingView: UIView {
    
    var iconView: UIImageView!
    var addButton: UIButton!
    let offset: CGFloat = -0.25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // icon view
        iconView = UIImageView()
        iconView.tintColor = .white
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconView)
        
        // add button
        let plusIcon = UIImage(systemName: "plus.circle.fill")
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.isHidden = true
        addButton.setImage(plusIcon, for: .normal)
        addButton.tintColor = .green
        self.addSubview(addButton)
        
        // alignment
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: offset),
            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10)
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
