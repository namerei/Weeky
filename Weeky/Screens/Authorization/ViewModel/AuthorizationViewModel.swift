//
//  ContentViewViewModel.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation

class AuthorizationViewModel: ObservableObject
{
    @Published var name = ""
    @Published var password = ""
    @Published var error = ""
    
    @Published var authorizationManager =  AuthorizationManager()
    @Published var user: User?
    
//    init(email: String = "", password: String = "",  authorizationManager: AuthorizationManager) {
//        self.email = email
//        self.password = password
//        
//        let user = User(email: email, password: password)
//        
//        self.authorizationManager = AuthorizationManager(user: user)
//    }
    
    func login(completion: @escaping (Bool) -> Void) {
        print("LOGIN")
        print(name, password)
        
        authorizationManager.fetchAllUsers { users, error in
            if let error = error {
                print("Error fetching users: \(error)")
                completion(false) // Сообщаем об ошибке через замыкание
                return
            }
            
            guard let users = users else {
                print("No users found")
                completion(false) // Сообщаем, что пользователей нет
                return
            }
            
            let userExists = self.checkedUserExist(users)
            if userExists {
                completion(true)
            } else {
                completion(false) // Сообщаем, что пользователь не найден
            }
        }
    }
    
    func checkedUserExist(_ users: [User])->Bool {
        users.forEach({
            if $0.name == self.name && $0.password == self.password {
                self.user = $0
            }
        })
        return user != nil ? true : false
    }
    
    func validate()->Bool {
        if (name != "" && password != "") {
            error = ""
            return true
        } else {
            error = "Пустые поля"
            return false
        }
    }
    
    func eraseFields() {
        name = ""
        password = ""
    }
    
    func saveNewUserToDB() {
//        let user = User(email: email)
    }
    
    func updateUserData(for user: User, name: String?, password: String?) {
        
//        authorizationManager.updateUserName(for: "123", with: "1234")
//        authorizationManager.updateUserName(for: , with: )
    }
}
