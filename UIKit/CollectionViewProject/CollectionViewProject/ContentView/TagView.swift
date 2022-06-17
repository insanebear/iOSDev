//
//  TagView.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/10.
//

import UIKit

class TagView: UIView {
    private var isSelected: Bool = false
    private var tagLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1,
                                          compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.didTapTagView(_:)))
        )
        self.setTagViewColor()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: tagLabel.leadingAnchor, constant: -8),
            self.trailingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: 8),
            self.topAnchor.constraint(equalTo: tagLabel.topAnchor, constant: -8),
            self.bottomAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2.5
        self.layer.masksToBounds = true
    }
    
    func setText(with text: String) {
        tagLabel.text = "#\(text)"
    }
    
    @objc func didTapTagView(_ sender: UITapGestureRecognizer) {
        var tag = tagLabel.text ?? ""
        tag.removeFirst()
        print(tag)
        
        isSelected.toggle()
        setTagViewColor()
    }
    
    func setTagViewColor() {
        if isSelected {
            self.backgroundColor = .white
            tagLabel.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1
        } else {
            self.backgroundColor = .systemRed
            tagLabel.textColor = .white
            self.layer.borderColor = nil
            self.layer.borderWidth = 0
        }
    }
}
