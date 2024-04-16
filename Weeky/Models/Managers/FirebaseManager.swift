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
    
    func uploadData(data: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection("Task").document("exampleDocument").setData(data) { error in
            completion(error)
        }
    }
    
    func fetchUserData(completion: @escaping ([User]?, Error?) -> Void) {
            db.collection("users").getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    var users = [User]()
                    for document in querySnapshot!.documents {
                        let userData = document.data()
                        // Парсинг данных пользователя из userData и создание объекта User
                        let user = User(name: userData["name"] as? String ?? "",
                                        password: userData["password"] as? String ?? "",
                                        tasks: [])
                        users.append(user)
                    }
                    completion(users, nil)
                }
            }
    }
        
        func fetchAllTasks(completion: @escaping ([Task]?, Error?) -> Void) {
            db.collectionGroup("tasks").getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    var tasks = [Task]()
                    for document in querySnapshot!.documents {
                        let taskData = document.data()
                        // Парсинг данных задачи из taskData и создание объекта Task
                        let task = Task(title: "from FB", colorName: "Yellow light")
                        tasks.append(task)
                    }
                    completion(tasks, nil)
                }
            }
        }
}
