//
//  WeekPageViewModel.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseCore

class HomeViewModel: ObservableObject {
    @Published var firebaseManager = TaskDBManager()
    @Published var currentUser : User?
    
//    @State var error : Error?
    @Published var storedTasks: [Task] = [
    ]
    
    //MARK: UI elements
    //Current Week Days
    @Published var currentWeek: [Date] = []
    //Current Day
    @Published var currentDay: Date = Date()
    // Filtering Task
    @Published var filteredTasks: [Task]?
    
    init(){
//        fetchAllData()
        
        filteringTodayTask()
        fetchCurrentWeek()
//        print("", Date().millisecondsSince1970)
    }
    
    //MARK: - HomePage UI functions
    func filteringTodayTask(){
//        fetchAllData()
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            var filtered = self.storedTasks.filter { task in
                guard let date = task.dateString.toDate() else { return false }
                return calendar.isDate(date, inSameDayAs: self.currentDay)
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
    
    
    //MARK: - Calendar UIFuncione
    func allTaskInDay(_ day: Date)->[Task] {
        print("ALLTASK: \(day)")
        var result = [Task]()
        //        DispatchQueue.global(qos: .userInteractive).async {
        let calendar = Calendar.current
        
        result = self.storedTasks.filter { task in
            guard let date = task.dateString.toDate() else { return false }
            return calendar.isDate(date, inSameDayAs: day)
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
    
    
    //MARK: - FirebaseDB
    
    func addTask(_ task: Task) {
        firebaseManager.uploadTask(task) { error in
            self.storedTasks.append(task)
            self.checkFor(error)
            self.filteringTodayTask()
        }
//        firebaseManager.uploadTask(task: task, user: user) { error in
//            self.storedTasks.append(task)
//            self.checkFor(error)
//            self.filteringTodayTask()
//        }
    }
    
    func deleteTask(_ task: Task) {
        storedTasks.removeAll { $0.id == task.id }
        
        firebaseManager.deleteTask(task) { error in
            self.checkFor(error)
        }
        filteringTodayTask()
    }
    
    func fetchAllData() {
        self.storedTasks.removeAll()
        
        print("FETCH")
        firebaseManager.fetchAllTasks { fetchedTasks, error in
            self.checkFor(error)
            
            guard let fetchedTasks = fetchedTasks else { return }
            self.storedTasks += fetchedTasks
            self.filteringTodayTask()
        }
    }
    
    //MARK: - Helpers
    func taskIsCorrect(_ task: Task)->Bool {
        !task.title.isEmpty
    }
    
    func taskAdded(_ task: Task)->Bool {
        if taskIsCorrect(task) {
            addTask(task)
            return true
        }
        return false
    }
    
    func checkFor(_ error: Error?) {
        if error != nil {
            print(error!.localizedDescription)
        }
    }
    
    func addUser(_ user: User) {
        self.currentUser = user
        firebaseManager.addUser(user)
        self.fetchAllData()
        print("ADDUSER", self.currentUser)
    }
}

