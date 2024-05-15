//
//  NotificationManager.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 10.05.24.
//

import SwiftUI

class NotificationManager{
    
    static let shared = NotificationManager()
    private var minutesBefore = -15
    
    func requestAuthorization(){
        let options:UNAuthorizationOptions = [.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { sucess, error in
            if let error = error{
                print("Error: - \(error.localizedDescription)")
            }else{
                print("Sucess")
            }
        }
    }
    
    func scheduleNotification(task: Task) {
        
//        let date = Date().addingTimeInterval(10) // Ваша дата
        let date = task.dateString.toDate()!.addingTimeInterval(TimeInterval(60 * minutesBefore))// Ваша дата

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        print("Год: \(components.year ?? 0)")
        print("Месяц: \(components.month ?? 0)")
        print("День: \(components.day ?? 0)")
        print("Часы: \(components.hour ?? 0)")
        print("Минуты: \(components.minute ?? 0)")
        print("Секунды: \(components.second ?? 0)")

        // Создание DateComponents из Date
        let dateComponents = DateComponents(year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second)

//        print(dateComponents)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        
        let content = UNMutableNotificationContent()
        content.title = "У вас скоро задача"
//        content.body = "This is my first ever location Notification implemetation in SwiftUI"
        content.body = task.title
        
        print(task.title, date, "\n")
        
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
//    func scheduleTaskNotifications() {
//        // Пример задачи с указанным временем уведомления (для примера, время указано через 5 секунд от текущего времени)
//        let task1 = Task(title: "Проверить почту", time: Date().addingTimeInterval(10))
//        scheduleNotification(for: task1)
//
//        // Добавьте другие задачи здесь
//    }
//
//
//
//    func scheduleNotification(for task: Task) {
//        print(task)
//        let content = UNMutableNotificationContent()
//        content.title = "Напоминание"
//        content.body = task.title
//
//        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: task.time)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        print(request)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Ошибка при установке локального уведомления: \(error.localizedDescription)")
//            } else {
//                print("установка локального уведомления произошла")
//            }
//        }
//    }
}
