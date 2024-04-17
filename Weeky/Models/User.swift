//
//  User.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    var id                  = ""
    var name: String        = ""
    var password: String    = ""
    var isAuthorized: Bool  = false
    
    var tasksRef: String    = ""
}
