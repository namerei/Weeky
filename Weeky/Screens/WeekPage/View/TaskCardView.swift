//
//  TaskCardView.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 15.04.24.
//

import SwiftUI

struct TaskCardView: View {
    @State var task: Task
//    @State var taskIsDone = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.title2)
                
                Text("\(task.date.showOnlyTimeString())")
                    .font(.subheadline)
            }
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        task.isCompleted.toggle()
                        print(task)
                    }
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.square" : "square")
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
