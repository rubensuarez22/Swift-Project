//
//  notifications.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 07/03/24.
//

import UIKit
import UserNotifications
/*
class notifications: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForPermission()
    }
}

func checkForPermission(){
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.getNotificationSettings{ settings in
        switch settings.authorizationStatus {
        case .authorized:
            self.dispatchNotification()
        case .denied:
            return
        case .notDetermined:
            notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                if didAllow{
                    self.dispatchNotification()
                }
            }
        default:
            return
        }
    }
}

func dispatchNotification() {
    let title = "Novedad"
    let body = "Nueva publicacion ha sido subida"
    let notificationCenter = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    
}
*/
