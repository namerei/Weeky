//
//  Item.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 12.01.2024.
//

import Foundation

struct Item:  Identifiable, Equatable {
    var name: String
    var isCompleted: Bool = false
    var id: UUID = UUID()
}
