//
//  AutorizationManager.swift
//  Weeky
//
//  Created by namerei on 16.04.24.
//

import SwiftUI
import Firebase
import FirebaseCore

class AuthorizationManager: ObservableObject {
    private let db = Firestore.firestore()
    
//    @Published var user : User
//    @Published var error: Error? = nil
    
//    init(user: User, error: Error? = nil) {
//        self.user = user
//        self.error = error
//    }
    
//    func uploadTask(_ task: Task, completion: @escaping (Error?) -> Void) {
//        // Ссылка на коллекцию задач пользователя
//        let tasksRef = db.collection("Tasks")
//        
//        // Добавление задачи в коллекцию
//        tasksRef.addDocument(data: ["id": task.id,
//                                    "title": task.title,
//                                    "dateString": task.dateString, "colorName": task.colorName, "isCompleted": task.isCompleted]
//        ) { error in
//            if let error = error {
//                completion(error)
//            } else {
//                completion(nil)
//            }
//        }
//    }
    
    
    func fetchAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        db.collectionGroup("Users").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var users = [User]()
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    print(userData)
                    
                    users.append(self.constructUser(from: userData))
                }
                completion(users, nil)
            }
        }
    }
    
    func deleteTask(_ task: Task, completion: @escaping (Error?) -> Void) {
//            // Ссылка на документ задачи пользователя
//            let taskId = task.id
//            let userTaskRef = db.collection("Tasks").document("id")
//
//            // Удаление задачи из коллекции
//            userTaskRef.delete { error in
//                if let error = error {
//                    completion(error)
//                } else {
//                    completion(nil)
//                }
//            }
        }
    
    //MARK: - helpers
    func constructUser(from userData: [String : Any])->User {
//        Task(id: userData["id"] as? String ?? "",
//             title: userData["title"] as? String ?? "",
//             dateString: userData["dateString"] as? String ?? "",
//             colorName: userData["colorName"] as? String ?? "",
//             isCompleted: userData["isCompleted"] as? Bool ?? false)
        User()
    }
    
}

