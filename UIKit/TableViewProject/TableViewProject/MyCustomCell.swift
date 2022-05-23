//
//  MyCustomCell.swift
//  TableViewProject
//
//  Created by Jayde Jeong on 2022/05/23.
//

import UIKit

class MyCustomCell: UITableViewCell {
    static let identifier = "myCustomCell"
    
    private var name: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    private var image: UIImageView = {
        let image = UIImageView(
            image: UIImage(systemName: "star")
        )
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(name)
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure (name: String) {
        self.name.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.name.text = nil
    }
}
