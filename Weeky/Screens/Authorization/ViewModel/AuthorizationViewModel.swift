//
//  ContentViewViewModel.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation

class AuthorizationViewModel: ObservableObject
{
    @Published var email = ""
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
        print(email, password)
        
        authorizationManager.fetchAllUsers { users, error in
//            print(users)
        }
        return false
    }
    
    func validate()->Bool {
        if (email != "" && password != "") {
            error = ""
            return true
        } else {
            error = "Пустые поля"
            return false
        }
    }
    
    func eraseFields() {
        email = ""
        password = ""
    }
    
    func saveNewUserToDB() {
//        let user = User(email: email)
    }
    
}
