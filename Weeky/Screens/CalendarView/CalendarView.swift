//
//  CalendarView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI
import UIKit

struct CalendarView: UIViewControllerRepresentable {
    @Binding var isCalendarViewShowed : Bool
    
    typealias UIViewControllerType = CalendarViewController
    
    func makeUIViewController(context: Context) -> CalendarViewController {
        let calendarViewController = CalendarViewController()
        return calendarViewController
    }
    
    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
        // Обновление контроллера, если необходимо
    }
}

class CalendarViewController: UIViewController, UIViewControllerTransitioningDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создайте и настройте ваш календарь здесь
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        // Добавьте календарь на экран
        view.addSubview(datePicker)
        
        // Установите ограничения или добавьте другие настройки, если необходимо
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Покажите календарь при загрузке контроллера
        showCalendar()
    }
    
    private func showCalendar() {
        // Ваша логика для показа календаря
    }
}
