//
//  ImageViewCell.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/08/16.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    static let identifier = "imageViewCell"
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.layer.cornerRadius = 20
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData = NSData(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = imageData {
                    let image = UIImage(data: imageData as Data)
                    self.imageView.image = image
                    self.imageView.contentMode = .scaleAspectFill
                    self.imageView.clipsToBounds = true
                }
            }
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
