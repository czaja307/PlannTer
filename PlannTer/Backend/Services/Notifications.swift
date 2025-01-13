//
//  Untitled.swift
//  PlannTer
//
//  Created by Jakub Czajkowski on 16/12/2024.
//
import UserNotifications

func checkForPermissions() {
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.getNotificationSettings { settings in
        if settings.authorizationStatus == .notDetermined {
            notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        }
    }
}

func dispatchNotification(identifier: String, title: String, body: String, date: Date) {
    let notificationCenter = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = .default
    
    let calendar = Calendar.current
    let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    notificationCenter.add(request)
}
