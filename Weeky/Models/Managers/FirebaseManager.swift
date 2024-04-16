//
//  FirebaseManager.swift
//  Weeky
//
//  Created by namerei on 16.04.24.
//

import SwiftUI
import Firebase
import FirebaseCore

class FirebaseManager: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var fetchedData: [String: Any]? = nil
    @Published var error: Error? = nil
    
    func fetchData() {
        print(db)
        db.collection("data").document("exampleDocument").getDocument { (document, error) in
            if let document = document, document.exists {
                self.fetchedData = document.data()
                self.error = nil
            } else {
                self.error = error
            }
        }
    }
    
    func uploadTask(_ task: Task, completion: @escaping (Error?) -> Void) {
            // Ссылка на коллекцию задач пользователя
            let tasksRef = db.collection("Tasks")
            
            // Добавление задачи в коллекцию
        tasksRef.addDocument(data: ["id": task.id,
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
    
    func fetchUserData(completion: @escaping ([User]?, Error?) -> Void) {
            db.collection("Users").getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    var users = [User]()
                    for document in querySnapshot!.documents {
                        let userData = document.data()
                        // Парсинг данных пользователя из userData и создание объекта User
                        let user = User(email: userData["email"] as? String ?? "",
                                        password: userData["password"] as? String ?? "",
                                        Tasks: [])
                        users.append(user)
                    }
                    completion(users, nil)
                }
            }
    }
        
        func fetchAllTasks(completion: @escaping ([Task]?, Error?) -> Void) {
            db.collectionGroup("Tasks").getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    var tasks = [Task]()
                    for document in querySnapshot!.documents {
                        let taskData = document.data()
//                        print(taskData)
                        // Парсинг данных задачи из taskData и создание объекта Task
                        let task = Task(id: taskData["id"] as? String ?? "", title: taskData["title"] as? String ?? "",
                                        dateString: taskData["dateString"] as? String ?? "",
                                        colorName: taskData["colorName"] as? String ?? "",
                                        isCompleted: taskData["isCompleted"]! as! Bool)
                        tasks.append(task)
                    }
                    completion(tasks, nil)
                }
            }
        }
}
