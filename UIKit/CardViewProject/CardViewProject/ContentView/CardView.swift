//
//  CardView.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardView: UIView {
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    
    private var isTapped: Bool = false
    private var showOverlay: Bool = false
    
    private let filmLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.name = "film"
        return layer
    } ()
    
    private let overlayLayer: CALayer = {
        let layer = CALayer()
        layer.name = "overlay"
        layer.isHidden = true
        return layer
    } ()
    
    private var cardImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    } ()
    
    var cardBasicInfoView: CardBasicInfoView!
    var cardDetailInfoView: CardDetailInfoView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(width: CGFloat,
                     ratio: CGFloat,    // ratio: 1.5 == 2 : 3
                     filmType: FilmType = .gradient,
                     filmColor: UIColor = .black,
                     overlayOpacity: CGFloat = 0.5) {
        
        self.init(frame: .zero)
        
        self.width = width
        self.height = width * ratio
        
        filmLayer.colors = [filmType.getColoredFilm(color: filmColor).0,
                            filmType.getColoredFilm(color: filmColor).1]
        overlayLayer.backgroundColor = UIColor.black.withAlphaComponent(overlayOpacity).cgColor
        
        initialSetup()
        setupAlignment()
        setupCardSize()
    }
    
    // initializer which doesn't need width and height
    convenience init(filmType: FilmType = .gradient,
                     filmColor: UIColor = .black,
                     overlayOpacity: CGFloat = 0.5) {
        
        self.init(frame: .zero)
        
        filmLayer.colors = [filmType.getColoredFilm(color: filmColor).0,
                            filmType.getColoredFilm(color: filmColor).1]
        overlayLayer.backgroundColor = UIColor.black.withAlphaComponent(overlayOpacity).cgColor
        
        initialSetup()
        setupAlignment()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        filmLayer.frame = cardImageView.bounds
        overlayLayer.frame = cardImageView.bounds
        
        self.setNeedsDisplay()
    }
    
    func initialSetup() {
        // Setup card view interactions
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.handleTapCardView(_:)))
        )
        
        // Setup card shape
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        // Setup cardImageView
        cardImageView.contentMode = .scaleAspectFill
        cardImageView.sizeToFit()
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardImageView)
        
        // Setup layer on cardImageView
        cardImageView.layer.insertSublayer(filmLayer, at: 0)
        cardImageView.layer.insertSublayer(overlayLayer, at: 1)
        
        // Setup cardBasicInfoView
        cardBasicInfoView = CardBasicInfoView()
        cardBasicInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardBasicInfoView)
        
        // Setup cardDetailInfoView - Hidden at first
        cardDetailInfoView = CardDetailInfoView()
        cardDetailInfoView.translatesAutoresizingMaskIntoConstraints = false
        cardDetailInfoView.isHidden = true
        self.addSubview(cardDetailInfoView)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setContents(image: UIImage?, title: String, subtitle: String, memo: String) {
        self.cardImageView.image = image
        self.cardBasicInfoView.setContents(title: title, subTitle: subtitle)
        self.cardDetailInfoView.setContents(content: memo)
    }
    
    @objc func handleTapCardView(_ sender: UIGestureRecognizer) {
        // disable switching animation
        CATransaction.setDisableActions(true)
        
        if showOverlay {
            cardBasicInfoView.isHidden = false
            cardDetailInfoView.isHidden = true
            overlayLayer.isHidden = true
            filmLayer.isHidden = false
            showOverlay = false
        } else {
            cardBasicInfoView.isHidden = true
            cardDetailInfoView.isHidden = false
            overlayLayer.isHidden = false
            filmLayer.isHidden = true
            showOverlay = true
        }
    }
}

// MARK: - Alignments

extension CardView {
    func setupAlignment() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: self.topAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            cardBasicInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            cardBasicInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cardDetailInfoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardDetailInfoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func setupCardSize() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: self.width),
            self.heightAnchor.constraint(equalToConstant: self.height)
        ])
    }
}
