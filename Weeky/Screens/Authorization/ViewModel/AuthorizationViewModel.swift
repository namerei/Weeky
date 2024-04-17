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
    
    
//    @Published var authorizationManager : AuthorizationManager!
    
//    init(email: String = "", password: String = "",  authorizationManager: AuthorizationManager) {
//        self.email = email
//        self.password = password
//        
//        let user = User(email: email, password: password)
//        
//        self.authorizationManager = AuthorizationManager(user: user)
//    }
    
    func login() {
        
    }
    
    func validate() {
        
    }
    
    func eraseFields() {
        email = ""
        password = ""
    }
    
}
