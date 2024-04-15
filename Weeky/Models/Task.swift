//
//  Task.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

struct Task: Identifiable{
    var id = UUID().uuidString
    var title: String
    var date: Date
    var color: UIColor
    var isCompleted: Bool = false
}
