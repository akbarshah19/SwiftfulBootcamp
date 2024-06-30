//
//  LocalNotificationBootcamp.swift
//  SwiftfulBootcamp
//
//  Created by Akbarshah Jumanazarov on 4/21/24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestAuth() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error)
            } else {
                print("Success!")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is Notification"
        content.subtitle = "This is Subtitle"
        content.sound = .default
        content.badge = 1
        
        //time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 18
//        dateComponents.minute = 33
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //location
        let coordinate = CLLocationCoordinate2D(latitude: 0,
                                                longitude: 0)
        
        let region = CLCircularRegion(center: coordinate,
                                      radius: 50,
                                      identifier: UUID().uuidString)
        
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
               print(error)
            } else {
                print("Notification Scheduled!")
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.shared.requestAuth()
            }
            
            Button("Schedule Notification") {
                NotificationManager.shared.scheduleNotification()
            }
            
            Button("Cancel Notification") {
                NotificationManager.shared.cancelNotification()
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().setBadgeCount(0) { error in
                if let error {
                    print(error)
                } else {
                    print("Badge is set to 0")
                }
            }
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}
