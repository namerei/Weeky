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
        Task(taskTitle: "Сходить на пробежку", taskDescription: "Matkul Programming", taskDate: Date()),
        Task(taskTitle: "Медитация", taskDescription: "Matkul Programming", taskDate: Date()),
        Task(taskTitle: "Завтрак", taskDescription: "Nasi padang", taskDate: Date()),
        Task(taskTitle: "Накидать дизайн приложения в Figma", taskDescription: "ndomblong", taskDate: Date()),
        Task(taskTitle: "Встреча с Женей в Surf", taskDescription: "Matkul Programming", taskDate: Date()),
        Task(taskTitle: "Заказать продукты", taskDescription: "Matkul Programming", taskDate: Date())
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
        print("date nya dan", Date().millisecondsSince1970)
    }
    
    func filteringTodayTask(){
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            let filtered = self.storedTask.filter{
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
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
        
        (1...7).forEach{ day in
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

