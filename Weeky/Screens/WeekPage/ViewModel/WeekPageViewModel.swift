//
//  WeekPageViewModel.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation
import SwiftUI

class WeekPageViewModel: ObservableObject {
    
    @Published var storedTask: [Task] = [
        Task(title: "Сходить на пробежку", date: Date().addingTimeInterval(TimeInterval(1)), color: UIColor(.blue)),
        Task(title: "Медитация", date: Date().addingTimeInterval(TimeInterval(0)), color: UIColor(.blue)),
        Task(title: "Накидать дизайн", date: Date().addingTimeInterval(TimeInterval(0)), color: UIColor(.blue)),
        Task(title: "Заказать продукты", date: Date().addingTimeInterval(TimeInterval(0)), color: UIColor(.blue)),
        Task(title: "Встреча с Женей в Surf", date: Date().addingTimeInterval(TimeInterval(3)), color: UIColor(.blue)),
    ]
    
    //Current Week Days
    @Published var currentWeek: [Date] = []
    
    //Current Day
    @Published var currentDay: Date = Date()
    
    // Filtering Toda Task
    @Published var filteredTasks: [Task]?
    
    init(){
        fetchCurrentWeek()
        filteringTodayTask()
//        print("", Date().millisecondsSince1970)
    }
    
    func filteringTodayTask(){
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            let filtered = self.storedTask.filter{
                return calendar.isDate($0.date, inSameDayAs: self.currentDay)
            }
            
            DispatchQueue.main.async {
                withAnimation{
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek(){
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (0..<7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    //extraking date
    func extractDate(date: Date,format: String)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    //checking if current date is today
    func isToday(date: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }

    //checking if the currentHour is task Hour
    func isCurrentHour(date: Date)->Bool{
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentDate = calendar.component(.hour, from: Date())
        
        return hour == currentDate
    }
}

