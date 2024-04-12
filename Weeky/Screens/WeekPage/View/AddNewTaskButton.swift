//
//  AddNewTaskButton.swift
//  Weeky
//
//  Created by namerei on 11.04.24.
//

import SwiftUI

struct AddNewTaskButton: View {
    var body: some View {
        Button {
            print("button add new task")
//            viewModel.openEditTask = true
        } label: {
            Label {
                Text("Добавить задачу")
            } icon: {
                Image(systemName: "plus.app.fill")
            }
            .font(.title3.bold())
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .shadow(color: .black, radius: 0.5, x: 0.8, y: 0.5)
            .background {
                Capsule()
                    .fill(Color("Blue dark"))
                    .shadow(color: Color(UIColor.label), radius: 0.9, x: 0.5, y: 0.5)
                
            }
        }
//        .padding(.top, 30)
//        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AddNewTaskButton()
}
