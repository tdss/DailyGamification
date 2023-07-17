//
//  NotificationCenter.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 16/07/2023.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    let options: UNAuthorizationOptions = [.alert, .sound]
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            }else {
                print("SUCESSS")
                //Morning local motivational notifications
                self.scheduleLocalNotification(
                    identifier: "morning-motivational-notification",
                    title: "Morning motivational notification",
                    subtitle: "Check your goals for today!",
                    hour: 10,
                    minute: 36
                )
                
                //Evening local motivational notifications
                self.scheduleLocalNotification(
                    identifier: "evening-motivational-notification",
                    title: "Evening motivational notification",
                    subtitle: "Claim EXP for finished tasks!",
                    hour: 20,
                    minute: 38
                )
                print("NOTIFICATIONS SCHEDULED")
            }
        }
    }
    
    func scheduleLocalNotification(
        identifier: String,
        title: String,
        subtitle: String,
        hour: Int,
        minute: Int
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default

        var dateComponents = DateComponents()
        
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
}
