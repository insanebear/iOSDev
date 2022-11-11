//
//  LocationBasedNotificationViewController+Noti.swift
//  NotificationsProject
//
//  Created by Jayde Jeong on 2022/11/10.
//

import UIKit
import CoreLocation

extension LocationBasedNotificationViewController {
    func requestNotificationAuth(center: UNUserNotificationCenter) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                self.hasNotificationAuth = granted
            }
        }
    }
    
    func createNotificationTrigger(region: CLCircularRegion) {
        
        let content = UNMutableNotificationContent()
        content.title = "Hello from NotificationsProject!"
        content.body = "You've arrived in the destination region 😌"
        content.sound = .default
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)

        // Schedule the request with the system.
        notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
               print("Error: \(String(describing: error))")
           }
        }
        
        checkPendingNotifications()
    }
    
    func checkPendingNotifications() {
        // check current pending notification
        notificationCenter.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print(request.identifier)
            }
        })
    }
}

extension LocationBasedNotificationViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Received Notification")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Received Notification in Foreground")
        completionHandler([.banner, .badge, .sound])
    }
}
