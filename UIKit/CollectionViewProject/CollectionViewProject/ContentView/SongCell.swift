//
//  SongCell.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/05/31.
//

import UIKit

class SongCell: UICollectionViewCell {
    static let reuseIdentifier = "songCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.sizeToFit()
        
        return label
    } ()
    private var artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.sizeToFit()
        
        return label
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, artistLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.sizeToFit()
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)

        self.layer.cornerRadius = 5
        self.backgroundColor = .systemGreen
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(song: Song) {
        titleLabel.text = "\(song.trackName)"
        artistLabel.text = "\(song.artistName)"
    }
}
