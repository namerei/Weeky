//
//  Task.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

struct Task: Identifiable, Codable, Hashable {
    var id = UUID().uuidString
    var title: String = ""
    var date: Date = Date()
    var colorName = "Blue light"
    var isCompleted: Bool = false
}
