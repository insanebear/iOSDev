//
//  CardView+Views.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/08/03.
//

import UIKit

extension CardView {
    func setupLayers() {
        filmLayer = CAGradientLayer()
        filmLayer.name = "film"
        filmLayer.colors = [self.filmType.getColoredFilm(color: self.filmColor).0,
                            self.filmType.getColoredFilm(color: self.filmColor).1]
        
        overlayLayer = CALayer()
        overlayLayer.name = "overlay"
        overlayLayer.isHidden = true
        overlayLayer.backgroundColor = UIColor.black.withAlphaComponent(self.overlayOpacity).cgColor
    }
    
    func setupTextView() {
        // Setup cardBasicInfoView
        cardBasicInfoView = CardTextView()
        cardBasicInfoView!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardBasicInfoView!)
        
        // Setup cardDetailInfoView - Hidden at first
        cardDetailInfoView = CardTextView()
        cardDetailInfoView!.translatesAutoresizingMaskIntoConstraints = false
        cardDetailInfoView!.isHidden = true
        self.addSubview(cardDetailInfoView!)
    }
    
    func setupResourceView() {
        cardResourceStack = UIStackView()
        cardResourceStack!.translatesAutoresizingMaskIntoConstraints = false
        cardResourceStack!.axis = .horizontal

        cardResourceScrollView = UIScrollView()
        cardResourceScrollView!.translatesAutoresizingMaskIntoConstraints = false
        cardResourceScrollView!.isPagingEnabled = true
        cardResourceScrollView!.isScrollEnabled = true
        cardResourceScrollView!.addSubview(cardResourceStack!)
        
        self.addSubview(cardResourceScrollView!)
    }
    
    func setupAlignment() {
        if let cardResourceStack = cardResourceStack,
           let cardResourceScrollView = cardResourceScrollView {
            
            NSLayoutConstraint.activate([
                cardResourceScrollView.topAnchor.constraint(equalTo: self.topAnchor),
                cardResourceScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                cardResourceScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                cardResourceScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                
                cardResourceStack.topAnchor.constraint(equalTo: cardResourceScrollView.topAnchor),
                cardResourceStack.bottomAnchor.constraint(equalTo: cardResourceScrollView.bottomAnchor),
                cardResourceStack.leadingAnchor.constraint(equalTo: cardResourceScrollView.leadingAnchor),
                cardResourceStack.trailingAnchor.constraint(equalTo: cardResourceScrollView.trailingAnchor),
            ])
        }
        
        if let cardBasicInfoView = cardBasicInfoView {
            cardBasicInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
            cardBasicInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        }
        
        if let cardDetailInfoView = cardDetailInfoView {
            cardDetailInfoView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            cardDetailInfoView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
    }
    
    func setupCardSize() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: self.width),
            self.heightAnchor.constraint(equalToConstant: self.height)
        ])
    }
}
