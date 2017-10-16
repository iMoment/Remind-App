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
    }
    
    //  Content/Trigger/Request
    func timerRequest(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default()
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "userNotification.timer",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request)
    }
    
    func dateRequest(with components: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = "Date Trigger"
        content.body = "It is now the future!"
        content.sound = .default()
        content.badge = 1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: "userNotification.date",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request)
    }
    
    //  MARK: There is native framework trigger for locations in UserNotifications, but not reliable
    func locationRequest() {
        
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









