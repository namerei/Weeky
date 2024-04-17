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
    var dateString: String = ""
    var colorName = ""
    var isCompleted: Bool = false
    
    //2024-04-16 16:43:51
}


