//
//  User.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation
import Firebase
import FirebaseCore

struct User: Identifiable, Hashable, Codable {
    var id                  = ""
    var name: String        = ""
    var password: String    = ""
    var isAuthorized: Bool  = false
    
    var tasksRef: DocumentReference!
}
