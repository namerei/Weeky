//
//  User.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    var id                  = UUID().uuidString
    var email: String        = ""
    var password: String    = ""
    var isAuthorized: Bool  = false
    
    var Tasks: [Task]
}
