//
//  CardView.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardView: UIView {
    var data: Any? = nil
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    
    private var isTappable: Bool = false
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
    
    private var cardImageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    } ()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    var cardBasicInfoView: CardTextView!
    var cardDetailInfoView: CardTextView!

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
    
    convenience init(data: Any? = nil,
                     width: CGFloat,
                     ratio: CGFloat,    // ratio: 1.5 == 2 : 3
                     filmType: FilmType = .gradient,
                     filmColor: UIColor = .black,
                     overlayOpacity: CGFloat = 0.5,
                     isTappable: Bool = true) {
        
        self.init(frame: .zero)
        
        self.data = data
        self.width = width
        self.height = width * ratio
        self.isTappable = isTappable
        
        filmLayer.colors = [filmType.getColoredFilm(color: filmColor).0,
                            filmType.getColoredFilm(color: filmColor).1]
        overlayLayer.backgroundColor = UIColor.black.withAlphaComponent(overlayOpacity).cgColor
        
        initialSetup()
        setupAlignment()
        setupCardSize()
    }
    
    // initializer which doesn't need width and height
    convenience init(data: Any? = nil,
                     filmType: FilmType = .gradient,
                     filmColor: UIColor = .black,
                     overlayOpacity: CGFloat = 0.5,
                     isTappable: Bool = true) {
        
        self.init(frame: .zero)
        
        self.data = data
        self.isTappable = isTappable
        
        filmLayer.colors = [filmType.getColoredFilm(color: filmColor).0,
                            filmType.getColoredFilm(color: filmColor).1]
        overlayLayer.backgroundColor = UIColor.black.withAlphaComponent(overlayOpacity).cgColor
        
        initialSetup()
        setupAlignment()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded() // immediately fix stack view's bounds
        filmLayer.frame = stackView.bounds
        overlayLayer.frame = stackView.bounds
        
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
        
        // Setup cardImageScrollView
        stackView.axis = .horizontal
        
        cardImageScrollView.isPagingEnabled = true
        cardImageScrollView.isScrollEnabled = true
        cardImageScrollView.addSubview(stackView)
        self.addSubview(cardImageScrollView)
        
        // Setup cardBasicInfoView
        cardBasicInfoView = CardTextView()
        cardBasicInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardBasicInfoView)
        
        // Setup cardDetailInfoView - Hidden at first
        cardDetailInfoView = CardTextView()
        cardDetailInfoView.translatesAutoresizingMaskIntoConstraints = false
        cardDetailInfoView.isHidden = true
        self.addSubview(cardDetailInfoView)
    }
    
    func setContents(images: [UIImage?], title: String, subtitle: String, memo: String) {
        // FIXME: basic and detail info for a multi resourced card
        for case let image in images {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.sizeToFit()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: cardImageScrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: cardImageScrollView.heightAnchor),
            ])
        }
        stackView.layer.addSublayer(filmLayer)
        stackView.layer.addSublayer(overlayLayer)
        
        self.cardBasicInfoView.cardTitle.text = title
        self.cardBasicInfoView.subtitle.text = subtitle
        self.cardDetailInfoView.subtitle.text = memo

    }

    @objc func didTapCardView(_ sender: UIGestureRecognizer) {
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
            cardImageScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            cardImageScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardImageScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardImageScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: cardImageScrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: cardImageScrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: cardImageScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: cardImageScrollView.trailingAnchor),
            
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
