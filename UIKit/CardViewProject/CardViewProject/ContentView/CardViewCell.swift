//
//  CardViewCell.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardViewListCell: UICollectionViewCell {
    static let identifier = "cardViewListCell"
    
    // This cardView size depends on a cell size.
    // The cell size depends on collection view compositional layout.
    private let cardView = CardView(filmType: .gradient,
                            filmColor: .systemGreen,
                            overlayOpacity: 0.5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            // Make cardView fit to the cell size
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(data: MyData) {
        cardView.setContents(images: [data.image],
                             title: data.title,
                             subtitle: data.author,
                             memo: data.memo)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.setContents(images: [],
                             title: "",
                             subtitle: "",
                             memo: "")
    }
}

class CardViewPageCell: UICollectionViewCell {
    static let identifier = "cardViewPageCell"
    
    // This cardView size depends on a cell size.
    // The cell size depends on collection view compositional layout.
    private let cardView = CardView(filmType: .gradient,
                            filmColor: .black,
                            overlayOpacity: 0.2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            // Make cardView fit to the cell size
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(data: MyData) {
        cardView.setContents(images: [data.image],
                             title: data.title,
                             subtitle: data.author,
                             memo: data.memo)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardView.setContents(images: [],
                             title: "",
                             subtitle: "",
                             memo: "")
    }
}
