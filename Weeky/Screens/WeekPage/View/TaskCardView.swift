//
//  TaskCardView.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 15.04.24.
//

import SwiftUI

struct TaskCardView: View {
    var taskTitle: String
    var taskTime: String
    @State var taskIsDone = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(taskTitle)
                    .font(.title2)
                Text(taskTime)
                    .font(.subheadline)
            }
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        taskIsDone.toggle()
                    }
                }) {
                    Image(systemName: taskIsDone ? "checkmark.square" : "square")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Button(action: {
                    // Handle edit button action
                }) {
                    Image(systemName: "pencil")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
    }
}
