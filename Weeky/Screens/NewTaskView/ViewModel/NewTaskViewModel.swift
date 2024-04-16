//
//  NewTaskViewModel.swift
//  Weeky
//
//  Created by namerei on 11.04.24.
//

import Foundation
import SwiftUI

//class NewTaskViewModel: ObservableObject {
//    @Published var task =
//    @Published var taskColor: String = "Yellow"
//    @Published var taskType: String = "Basic"
//    @Published var taskDeadline: Date = Date()
//    @Published var showDatePicker = false
//    
//    var editTask: Task?
//
//    init(editTask: Task?) {
//        self.editTask = editTask
//    }
//
//    // MARK: Adding or Updating Task to Core Data
//    func upsertTask(context: NSManagedObjectContext) -> Bool {
////        let task = editTask ?? Task(context: context)
////
////        task.title = taskTitle
////        task.color = taskColor
////        task.deadline = taskDeadline
////        task.type = taskType
////        task.isCompleted = false
////
////        // MARK: Notifying VM's listeners to update UI
////        if let _ = try? context.save() {
////            objectWillChange.send()
////            return true
////        }
//        return false
//    }
//
//    func deleteTask(task: Task, context: NSManagedObjectContext) {
////        context.delete(task)
//        try? context.save()
//    }
//
//    // MARK: Resetting Data
//    func resetTaskData() {
//        taskType = "Basic"
//        taskColor = "Yellow"
//        taskTitle = ""
//        taskDeadline = Date()
//    }
//
//    func setup() {
//        guard let task = editTask else {
//            return
//        }
//
////        taskType = task.type ?? "Basic"
////        taskColor = task.color ?? "Yellow"
////        taskTitle = task.title ?? ""
////        taskDeadline = task.deadline ?? Date()
//    }
//}

//class NewTaskViewModel: ObservableObject {
//    @EnvironmentObject var homeViewModel: HomeViewModel
//    @Published var dateFromCalendar: Date?
//    @Published var task : Task
//    @Published var myTasks = [Task]()
//    @Published var homeViewModel: HomeViewModel
    
//    init(task: Task = Task()) {
//        self.task = task
//        print(homeViewModel.storedTask)
//        self.homeViewModel = viewModel
        
        //MARK: - write in DB
//        if task != nil {
//            homeViewModel.storedTask.append(task)
//        }
//        myTasks.append(task)
//        print("Mytasks: \(myTasks)")
//    }
    
    
//}
