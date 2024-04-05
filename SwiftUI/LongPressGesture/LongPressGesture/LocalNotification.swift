//
//  LocalNotification.swift
//  LongPressGesture
//
//  Created by mac on 02/04/24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization()
    {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { success, error in
            if let error = error {
                print("ERROR : \(error)")
            }
            else{
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "My first Notification"
        content.subtitle = "That's too easy"
        content.sound = .default
        content.badge = 1
        
//        time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
//        calender
//        var dateComponents = DateComponents()
//        dateComponents.hour = 15
//        dateComponents.minute = 46
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //location
//        let coordinates = CLLocationCoordinate2D(latitude: 21.233372, longitude: 72.863664)
//        let region = CLCircularRegion(center: coordinates, radius: 50, identifier: UUID().uuidString)
//        region.notifyOnExit = true
//        region.notifyOnEntry = true
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}

struct LocalNotification: View {
    var body: some View {
        VStack(spacing : 40)
        {
            Button("Request permission")
            {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification")
            {
                NotificationManager.instance.scheduleNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotification_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotification()
    }
}
