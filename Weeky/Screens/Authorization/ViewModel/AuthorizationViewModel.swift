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
    
    func createAccount() {

        let newUser = User(name: name, password: password)
        let dataToUpload = newUser.toData()
        
        let usersRef = authorizationManager.db.collection("Users")
        
        //MARK: - can edit password/ if name is exist
        usersRef.document(newUser.name).setData(dataToUpload)
        
        /*
        let newUser = User(name: name, password: password)
        print("CREATE : \(newUser)")
            
        authorizationManager.db.collection("Users").addDocument(data: newUser.toData()) { error in
                if let error = error {
                    print("Ошибка при добавлении документа: \(error)")
                } else {
                    print("Документ успешно добавлен")
                }
            }
         */
    }
    
    func updateUserData(for user: User, name: String?, password: String?) {
//        
//        let usersRef = authorizationManager.db.collection("Users")
//        if name != nil {
//        let newUser = User(name: name, password: password)
//        let dataToUpload = newUser.toData()
//        
//        usersRef.document(newUser.name).setData(dataToUpload)
//        authorizationManager.updateUserName(for: , with: )
    }
}
