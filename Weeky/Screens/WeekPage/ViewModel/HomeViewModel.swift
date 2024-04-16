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
    @StateObject var firebaseManager = FirebaseManager()
//    @State var authorized = false
    
    @State var error : Error?
    
    @Published var storedTasks: [Task] = [
        Task(title: "Медитаця", dateString: "2024-04-16 16:20:00", colorName: "Orange light", isCompleted: false),
        Task(title: "Спорт", dateString: "2024-04-16 18:20:00", colorName: "Blue xlight", isCompleted: false),
    ]
    
    //Current Week Days
    @Published var currentWeek: [Date] = []
    //Current Day
    @Published var currentDay: Date = Date()
    // Filtering Task
    @Published var filteredTasks: [Task]?
    
    init(){
        fetchAllData()
        
        fetchCurrentWeek()
        filteringTodayTask()
//        print("", Date().millisecondsSince1970)
    }
    
    //MARK: - HomePage UI functions
    func filteringTodayTask(){
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            var filtered = self.storedTasks.filter{
                calendar.isDate($0.dateString.toDate()!, inSameDayAs: self.currentDay)
            }
            filtered.sort(by: {$0.dateString < $1.dateString})
            
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
    
    //extrakting date
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
    
    //MARK: - Calendar UIFuncions
    func allTaskInDay(_ day: Date)->[Task] {
        print("ALLTASK: \(day)")
        var result = [Task]()
//        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            result = self.storedTasks.filter{
                calendar.isDate($0.dateString.toDate()!, inSameDayAs: day)
            }
            result.sort(by: {$0.dateString.toDate()! < $1.dateString.toDate()!})
            
//            DispatchQueue.main.async {
//                withAnimation{
//                    result = self.storedTasks
//                }
//            }
//        }
        print("ALLTASK: \(result)")
        return result
    }
    
    //MARK: - write / read functions
    
    func taskIsCorrect(_ task: Task)->Bool {
        !task.title.isEmpty
    }
    
    func taskAdded(_ task: Task)->Bool {
        if taskIsCorrect(task) {
            storedTasks.append(task)
            filteringTodayTask()
            return true
        }
        return false
    }
    
    func deleteTask(_ task: Task) {
        storedTasks.removeAll { $0.id == task.id }
        filteringTodayTask()
    }
    
    //MARK: - work with firebase
    func fetchAllData() {
        print("FETCH")
        
        firebaseManager.fetchUserData { users, _ in
            print(users)
        }
        
        firebaseManager.fetchAllTasks { storedTasks, error in
            print(storedTasks)
        }
//        print(firebaseManager.fetchedData)
    }
    
}

