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
     let db = Firestore.firestore()
    
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
//                    print(userData)
                    
                    users.append(self.constructUser(from: userData))
                }
                completion(users, nil)
            }
        }
    }
    
    func updateUserName(for username: String, with newName: String) {
        let db = Firestore.firestore()
        
        // Запрос к коллекции "users" для поиска пользователя с заданным именем
        let usersRef = db.collection("Users")
        let query = usersRef.whereField("name", isEqualTo: username)
        
        // Получение результатов запроса
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching user documents: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("No user documents found")
                return
            }
            
            // Проверка наличия пользователей с заданным именем
            if snapshot.documents.isEmpty {
                print("User with username '\(username)' not found")
                return
            }
            
            // Перебор всех найденных документов (обычно должен быть только один)
            for document in snapshot.documents {
                // Получение идентификатора пользователя
                let userId = document.documentID
                
                // Обновление имени пользователя в базе данных
                let userRef = usersRef.document(userId)
                userRef.updateData(["name": newName]) { error in
                    if let error = error {
                        print("Error updating user name: \(error.localizedDescription)")
                    } else {
                        print("User name updated successfully")
                    }
                }
            }
        }
    }
    
//    func deleteTask(_ task: Task, completion: @escaping (Error?) -> Void) {
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
//        }
    
    //MARK: - helpers
    func constructUser(from userData: [String : Any]) -> User {
        User(id: userData["id"] as? String ?? "", name: userData["name"] as? String ?? "", password: userData["password"] as? String ?? "", tasksRef: userData["tasksRef"] as? DocumentReference)
        
//        , isAuthorized: userData["isAuthorized"] as? Bool ?? false
    }
    
    
}

