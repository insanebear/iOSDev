//
//  TimeBasedNotificationViewController.swift
//  NotificationsProject
//
//  Created by Jayde Jeong on 2022/11/10.
//

import UIKit

class TimeBasedNotificationViewController: UIViewController {
    var topStackView: UIStackView!

    var setNotificationButton: UIButton!

    var notificationStatusLabel: UILabel!
    var notificationTimeLabel: UILabel!

    var hasNotificationAuth = false {
        didSet {
            notificationStatusLabel.text = hasNotificationAuth ? "Notification O" : "Notification X"
        }
    }
    
    var timeString: String = "No scheduled Noti" {
        didSet {
            notificationTimeLabel.text = timeString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        setViews()
        setConstraints()
        
        checkAuthorization()
    }

    func checkAuthorization() {
        // notification
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                let status = settings.authorizationStatus
                
                switch status {
                case .authorized:
                    self.hasNotificationAuth = true
                case .notDetermined:
                    self.hasNotificationAuth = false
                    self.requestNotificationAuth()
                default:
                    self.hasNotificationAuth = false
                    self.openSettings()
                }
            }
        }
    }
    
    func requestNotificationAuth() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                self.hasNotificationAuth = granted
            }
        }
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil) // open this app's settings
            }
        }
    }
    
    @objc func setNotification(_ sender: UITapGestureRecognizer) {
        let content = UNMutableNotificationContent()
        content.title = "Hello from NotificationsProject!"
        content.body = "10 seconds past 😌"
        content.sound = .default
        
        let calendar = Calendar.current
        var date = Date() // current time
        date.addTimeInterval(10) // after 10 seconds
        
        var dateComponents = DateComponents()
        dateComponents.calendar = calendar
        dateComponents.hour = calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)
        dateComponents.second = calendar.component(.second, from: date)

        timeString = "\(dateComponents.hour!) : \(dateComponents.minute!) : \(dateComponents.second!)"
        
        // create a time based trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
    }
}

extension TimeBasedNotificationViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Received Notification in Foreground")
        completionHandler([.banner, .badge, .sound])
    }
}
