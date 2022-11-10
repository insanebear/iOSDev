//
//  LocationBasedNotificationViewController+Noti.swift
//  NotificationsProject
//
//  Created by Jayde Jeong on 2022/11/10.
//

import UIKit

extension LocationBasedNotificationViewController {
    func requestNotificationAuth(center: UNUserNotificationCenter) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                self.hasNotificationAuth = granted
            }
        }
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
