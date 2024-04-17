//
//  FirebaseManager.swift
//  Weeky
//
//  Created by namerei on 16.04.24.
//

import SwiftUI
import Firebase
import FirebaseCore

class TaskDBManager: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var user : User?
    @Published var error: Error? = nil
    
    
//    init(user: User, error: Error? = nil) {
//        self.user = user
//        self.error = error
//    }
    
    func uploadTask(_ task: Task, completion: @escaping (Error?) -> Void) {
        // Ссылка на коллекцию задач пользователя
        guard let userName = user?.name else { return }
        let userRef = db.collection("Users").document(userName).collection("Tasks").document(task.id)
        
        // Добавление задачи в коллекцию
        userRef.setData(["id" : task.id,
            "title": task.title,
                         "dateString": task.dateString, "colorName": task.colorName, "isCompleted": task.isCompleted]
        ) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    
    func fetchAllTasks(completion: @escaping ([Task]?, Error?) -> Void) {
        guard let userName = self.user?.name else { return }
        let userRef = db.collection("Users").document(userName).collection("Tasks")

        userRef.getDocuments { (querySnapshot, error) in
            print("FETCH:", querySnapshot)
            if let error = error {
                completion(nil, error)
            } else {
                var tasks = [Task]()
                for document in querySnapshot!.documents {
                    let taskData = document.data()
                    
                    tasks.append(self.constructTask(from: taskData))
                }
                completion(tasks, nil)
            }
        }
    }
    
    func deleteTask(_ task: Task, completion: @escaping (Error?) -> Void) {
//            // Ссылка на документ задачи пользователя
        guard let userName = self.user?.name else { return }
        let taskRef = db.collection("Users").document(userName).collection("Tasks").document(task.id)
//
//            // Удаление задачи из коллекции
            taskRef.delete() { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
    
    //MARK: - helpers
    func constructTask(from taskData: [String : Any])->Task {
        Task(id: taskData["id"] as? String ?? "", 
             title: taskData["title"] as? String ?? "",
             dateString: taskData["dateString"] as? String ?? "",
             colorName: taskData["colorName"] as? String ?? "",
             isCompleted: taskData["isCompleted"] as? Bool ?? false)
    }
    
    func addUser(_ user: User) {
        self.user = user
    }
    
}
