//
//  MyCell.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/07.
//

import UIKit

class MyCell: UITableViewCell {

    static let identifier = "myCell"
    
    private let cellHeaderView = CellHeaderView()
    private let extraInfoView = ExtraInfoView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellHeaderView)
        contentView.addSubview(extraInfoView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            cellHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellHeaderView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellHeaderView.topAnchor.constraint(equalTo: self.topAnchor),
            cellHeaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellHeaderView.widthAnchor.constraint(equalToConstant: 50),
            
            extraInfoView.centerXAnchor.constraint(equalTo: cellHeaderView.centerXAnchor),
            extraInfoView.heightAnchor.constraint(equalToConstant: 20),
            extraInfoView.widthAnchor.constraint(equalToConstant: 50),
            extraInfoView.centerYAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: cellHeaderView.trailingAnchor, constant: 30),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure (text: String) {
        self.titleLabel.text = text
        cellHeaderView.label.text = text
        extraInfoView.label.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }

}
