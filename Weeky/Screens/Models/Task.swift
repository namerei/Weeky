//
//  Task.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import Foundation

struct Task: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
