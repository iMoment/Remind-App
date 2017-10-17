//
//  UNService.swift
//  Remind
//
//  Created by Stanley Pan on 17/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import Foundation
import UserNotifications

class UNService: NSObject {
    
    //  Shouldn't be able to initialize singleton from anywhere other than within the service itself, hence private init
    private override init() {}
    static let sharedInstance = UNService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No User Notification Authentication Error.")
            guard granted else {
                print("User denied access.")
                return
            }
            self.configure()
        }
    }
    
    //  MARK: Ran only if user has granted access
    func configure() {
        unCenter.delegate = self
        setupActionsAndCategories()
    }
    
    //  MARK: Categories specify what actions belong to which notifications
    func setupActionsAndCategories() {
        let timerAction = UNNotificationAction(identifier: NotificationActionId.timer.rawValue,
                                               title: "Run timer logic",
                                               options: [.authenticationRequired])
        
        let dateAction = UNNotificationAction(identifier: NotificationActionId.date.rawValue,
                                              title: "Run date logic",
                                              options: [.destructive])
        
        let locationAction = UNNotificationAction(identifier: NotificationActionId.location.rawValue,
                                                  title: "Run location logic",
                                                  options: [.foreground])
        
        let timerCategory = UNNotificationCategory(identifier: NotificationCategory.timer.rawValue,
                                                   actions: [timerAction],
                                                   intentIdentifiers: [])
        
        let dateCategory = UNNotificationCategory(identifier: NotificationCategory.date.rawValue,
                                                  actions: [dateAction],
                                                  intentIdentifiers: [])
        
        let locationCategory = UNNotificationCategory(identifier: NotificationCategory.location.rawValue,
                                                      actions: [locationAction],
                                                      intentIdentifiers: [])
        
        unCenter.setNotificationCategories([timerCategory, dateCategory, locationCategory])
    }
    
    func getAttachment(for id: NotificationAttachmentId) -> UNNotificationAttachment? {
        var imageName: String
        switch id {
        case .timer:
            imageName = "TimeAlert"
        case .date:
            imageName = "DateAlert"
        case .location:
            imageName = "LocationAlert"
        }
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else { return nil }
        do {
            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url, options: nil)
            return attachment
        } catch {
            print("We received an error: \(error.localizedDescription)")
            return nil
        }
    }
    
    //  Content/Trigger/Request
    func timerRequest(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default()
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.timer.rawValue
        
        if let attachment = getAttachment(for: .timer) {
            content.attachments = [attachment]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "userNotification.timer",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request)
    }
    
    func dateRequest(with components: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = "Date Triggered"
        content.body = "It is now the future!"
        content.sound = .default()
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.date.rawValue
        
        if let attachment = getAttachment(for: .date) {
            content.attachments = [attachment]
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: "userNotification.date",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request)
    }
    
    //  MARK: There is native framework trigger for locations in UserNotifications, but not reliable
    func locationRequest() {
        let content = UNMutableNotificationContent()
        content.title = "Location Triggered"
        content.body = "Welcome back you silly goose you!"
        content.sound = .default()
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.location.rawValue
        
        if let attachment = getAttachment(for: .location) {
            content.attachments = [attachment]
        }
        
        let request = UNNotificationRequest(identifier: "userNotification.location",
                                            content: content,
                                            trigger: nil)
        
        unCenter.add(request)
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    
    //  MARK: When user taps notification or any associated UI
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response.")
        
        completionHandler()
    }
    
    //  MARK: When your app is in the foreground, what should happen (should we badge? etc)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present.")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}









