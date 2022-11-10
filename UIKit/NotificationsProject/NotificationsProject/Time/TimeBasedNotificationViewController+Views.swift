//
//  TimeBasedNotificationViewController+Views.swift
//  NotificationsProject
//
//  Created by Jayde Jeong on 2022/11/10.
//

import UIKit

extension TimeBasedNotificationViewController {
    func setViews() {
        topStackView = UIStackView()
        topStackView.axis = .vertical
        topStackView.alignment = .center
        topStackView.spacing = 20
        topStackView.sizeToFit()
        
        notificationStatusLabel = UILabel()
        notificationStatusLabel.text = "Notification X"
        notificationStatusLabel.sizeToFit()

        setNotificationButton = UIButton()
        setNotificationButton.setTitle("Notification after 10s", for: .normal)
        setNotificationButton.setTitleColor(UIColor.white, for: .normal)
        setNotificationButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        setNotificationButton.backgroundColor = .systemBlue
        setNotificationButton.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        setNotificationButton.layer.cornerRadius = 10
        setNotificationButton.addTarget(self, action: #selector(setNotification(_:)), for: .touchUpInside)
        
        notificationTimeLabel = UILabel()
        notificationTimeLabel.text = timeString
        notificationTimeLabel.sizeToFit()
        
        topStackView.addArrangedSubview(notificationStatusLabel)
        topStackView.addArrangedSubview(setNotificationButton)
        topStackView.addArrangedSubview(notificationTimeLabel)

        self.view.addSubview(topStackView)
    }
    
    func setConstraints() {
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}
