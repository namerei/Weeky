//
//  TaskCardView.swift
//  Weeky
//
//  Created by namerei on 15.04.24.
//

import SwiftUI

struct TaskCardView: View {
    @EnvironmentObject var viewModel : HomeViewModel
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
                .fill(Color(task.colorName))
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
            HStack(spacing: 15) {
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
                        withAnimation {
                            viewModel.deleteTask(task)
                        }
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
