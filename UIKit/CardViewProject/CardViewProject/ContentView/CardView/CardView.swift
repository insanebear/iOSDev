//
//  CardView.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardView: UIView {
    private var cardType: CardType = .normal
    private var isTappable: Bool = false
    internal var showOverlay: Bool = false

    var data: Any? = nil
    internal var width: CGFloat = 0
    internal var height: CGFloat = 0
    
    internal var filmLayer: CAGradientLayer!
    internal var filmType: FilmType = .gradient
    internal var filmColor: UIColor = .black
    internal var overlayLayer: CALayer!
    internal var overlayOpacity: CGFloat = 0.5
    
    internal var cardResourceScrollView: UIScrollView?
    internal var cardResourceStack: UIStackView?
    
    var cardBasicInfoView: CardTextView?
    var cardDetailInfoView: CardTextView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup card shape
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(cardType: CardType = .normal,
                     data: Any? = nil,
                     width: CGFloat = 0,
                     ratio: CGFloat = 0,    // ratio: 1.5 == 2 : 3
                     filmType: FilmType = .gradient,
                     filmColor: UIColor = .black,
                     overlayOpacity: CGFloat = 0.5,
                     isTappable: Bool = true) {
        
        self.init(frame: .zero)
        
        self.cardType = cardType
        self.data = data
        self.width = width
        self.height = width * ratio
        self.isTappable = isTappable
        self.filmType = filmType
        self.filmColor = filmColor
        self.overlayOpacity = overlayOpacity
        
        initialSetup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded() // immediately fix stack view's bounds

        if let cardResourceStack = cardResourceStack {
            filmLayer.frame = cardResourceStack.bounds
            overlayLayer.frame = cardResourceStack.bounds
        }
        
        self.setNeedsDisplay()
    }
    
    func initialSetup() {
        
        // Setup card view interactions
        if isTappable {
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(
                // Tab Gesture
                UITapGestureRecognizer(target: self, action: #selector(self.didTapCardView(_:)))
            )
        }
        
        // Setup film & overlay layer
        setupLayers()
        
        // Setup text/image views
        switch cardType {
        case .noResource:
            setupTextView()
        case .noText:
            setupResourceView()
        case .normal:
            setupResourceView()
            setupTextView()
        }
        
        // Setup alignment
        setupAlignment()
        
        // Setup card size
        if width != 0 {
            setupCardSize()
        }
    }
    
    func configureResource(images: [UIImage?]) {
        // FIXME: basic and detail info for a multi resourced card
        guard let cardResourceStack = cardResourceStack,
              let cardResourceScrollView = cardResourceScrollView else {
            return
        }
        
        for case let image in images {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.sizeToFit()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            cardResourceStack.addArrangedSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: cardResourceScrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: cardResourceScrollView.heightAnchor),
            ])
        }
        
        cardResourceStack.layer.addSublayer(filmLayer)
        cardResourceStack.layer.addSublayer(overlayLayer)
    }
    
    func configureText(title: String, subtitle: String, memo: String) {
        if let cardBasicInfoView = cardBasicInfoView {
            cardBasicInfoView.cardTitle.text = title
            cardBasicInfoView.subtitle.text = subtitle
        }
        
        if let cardDetailInfoView = cardDetailInfoView {
            cardDetailInfoView.subtitle.text = memo
        }
    }
    
    @objc func didTapCardView(_ sender: UIGestureRecognizer) {
        // disable switching animation
        CATransaction.setDisableActions(true)
        
        if showOverlay {
            if let cardBasicInfoView = cardBasicInfoView {
                cardBasicInfoView.isHidden = false
            }
            
            if let cardDetailInfoView = cardDetailInfoView {
                cardDetailInfoView.isHidden = true
            }
            
            overlayLayer.isHidden = true
            filmLayer.isHidden = false
            showOverlay = false
        } else {
            if let cardBasicInfoView = cardBasicInfoView {
                cardBasicInfoView.isHidden = true
            }
            if let cardDetailInfoView = cardDetailInfoView {
                cardDetailInfoView.isHidden = false
            }
            
            overlayLayer.isHidden = false
            filmLayer.isHidden = true
            showOverlay = true
        }
    }
}
