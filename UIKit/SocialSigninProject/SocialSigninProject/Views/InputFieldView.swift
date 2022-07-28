//
//  InputFieldView.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/24.
//

import UIKit

class InputFieldView: UIStackView {
    /// axis: vertical, alignment: leading
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private lazy var errorMessage = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.alignment = .leading
        self.spacing = 10
        
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(textField)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init() {
        self.init(frame: .zero)
        
        // title label
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.textColor = .black
        
        // text field
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.contentHorizontalAlignment = .leading
        textField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/20).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
    }
    
    public func setPlaceholder(_ placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: "\(placeholder)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
    }
    
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    public func setTextEntrySecure(_ value: Bool) {
        textField.isSecureTextEntry = value
    }
    
    public func setAutocapitalization(type: UITextAutocapitalizationType) {
        textField.autocapitalizationType = type
    }
    
    public func getText() -> String? {
        return textField.text
    }
    
    public func setErrorMessage(with message: String) {
        textField.delegate = self
        
        errorMessage.text = message
        errorMessage.font = UIFont.preferredFont(forTextStyle: .caption1)
        errorMessage.textColor = .red
        errorMessage.isHidden = true
        
        self.addArrangedSubview(errorMessage)
    }
    
    public func showErrorMessage(_ value: Bool) {
        errorMessage.isHidden = !value
    }
}

extension InputFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorMessage.isHidden = true
    }
}
