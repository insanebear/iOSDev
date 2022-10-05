//
//  StretchyHeaderView.swift
//  SyncTabCollectionViewProject
//
//  Created by Jayde Jeong on 2022/10/05.
//

import UIKit

class StretchyHeaderView: UIView {
    var contentView: UIView!
    var imageView: UIImageView!

    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()
    var contentViewHeight = NSLayoutConstraint()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func initialSetup() {
        // contentView
        contentView = UIView()
        self.addSubview(contentView)

        // imageView
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)

        // constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            self.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])

        // contentView Constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        contentViewHeight = contentView.heightAnchor.constraint(equalTo: self.heightAnchor)
        contentViewHeight.isActive = true

        // imageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        imageViewHeight.isActive = true
    }

    func configure(image: UIImage?) {
        imageView.image = image
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        contentViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        contentView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
