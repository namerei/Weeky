//
//  WeekPageViewModel.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @State var authorized = true
//    @State var authorized = false
    
    @Published var storedTask: [Task] = [
//        Task(title: "Сходить на пробежку", date: Date().addingTimeInterval(TimeInterval(60 * 3 * 60)), color: Color(.blue)),
//        Task(title: "Сходить на пробежку", date: Date().addingTimeInterval(TimeInterval(60 * 12 * 60)), color: Color(.green)),
//        Task(title: "Медитация", date: Date().addingTimeInterval(TimeInterval(0)), color: Color(.blue)),
//        Task(title: "Накидать дизайн", date: Date().addingTimeInterval(TimeInterval(0)), color: Color("Orange light")),
//        Task(title: "Заказать продукты", date: Date().addingTimeInterval(TimeInterval(0)), color: Color("Blue light")),
//        Task(title: "Встреча с Женей в Surf", date: Date().addingTimeInterval(TimeInterval(3)), color: Color(.blue)),
    ]
    
    //Current Week Days
    @Published var currentWeek: [Date] = []
    //Current Day
    @Published var currentDay: Date = Date()
    // Filtering Task
    @Published var filteredTasks: [Task]?
    
    init(){
        fetchCurrentWeek()
        filteringTodayTask()
//        print("", Date().millisecondsSince1970)
    }
    
    //MARK: - HomePage UI functions
    func filteringTodayTask(){
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            var filtered = self.storedTask.filter{
                calendar.isDate($0.date, inSameDayAs: self.currentDay)
            }
            filtered.sort(by: {$0.date < $1.date})
            
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
    
    
    //MARK: - write / read functions
//    func taskIsCorrect()->Bool {
//    }
    
    func taskIsCorrect(_ task: Task)->Bool {
        !task.title.isEmpty
    }
    
    func taskAdded(_ task: Task)->Bool {
        if taskIsCorrect(task) {
            storedTask.append(task)
            return true
        }
        return false
    }
}

