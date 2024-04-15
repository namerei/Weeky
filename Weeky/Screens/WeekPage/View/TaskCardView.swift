//
//  TaskCardView.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 15.04.24.
//

import SwiftUI

struct TaskCardView: View {
    @State var task: Task
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(task.color)
                .frame(width: 10, height: 30)
                .padding(.top, 5)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.title2)
                
                Text("\(task.date.showOnlyTimeString())")
                    .font(.subheadline)
            }
//            .padding()
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
