//
//  TaskCardView.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 15.04.24.
//

import SwiftUI

struct TaskCardView: View {
    @State var task: Task
    @State var isEditing: Bool = false
    
    var body: some View {
        HStack {
            TaskCell()
            Spacer()
            ButtonsHStack()
        }
        .padding()
    }
    
    //MARK: - Views
    func TaskCell()->some View {
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
        }
    }
    
    func ButtonsHStack()->some View {
        VStack {
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
                    withAnimation {
                        isEditing.toggle()
                    }
                }) {
                    Image(systemName: "pencil")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                if isEditing {
                    Button(action: {
                        //MARK: Remove Task
                        // Handle edit button action
                    }) {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                }
            }
            Spacer()
        }
    }
}
