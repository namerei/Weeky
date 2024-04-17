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
    
//    init(email: String = "", password: String = "",  authorizationManager: AuthorizationManager) {
//        self.email = email
//        self.password = password
//        
//        let user = User(email: email, password: password)
//        
//        self.authorizationManager = AuthorizationManager(user: user)
//    }
    
    func login()->Bool {
        print("LOGIN")
        print(name, password)
        
        //MARK: - checking
        if (name == "123" && password == "123") {
            return true
        }
        
        authorizationManager.fetchAllUsers { users, error in
            users?.forEach({ user in
                print(user)
            })
//            print(users)
        }
        return false
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
    
}
