//
//  AddNewTaskButton.swift
//  Weeky
//
//  Created by namerei on 11.04.24.
//

import SwiftUI

struct AddNewTaskButton: View {
    @Binding var isShowingNewTaskView: Bool
    
    var body: some View {
        Button {
            print("button add new task")
            
            isShowingNewTaskView.toggle()
//            viewModel.openEditTask = true
        } label: {
            Label {
                Text("")
            } icon: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(width: 90, height: 90)
                    .background(Color("Yellow light"))
                    .clipShape(Circle())
            }
            .sheet(isPresented: $isShowingNewTaskView, content: {
//                MySideMenuView()
//                ModalView()
                NewTaskView()
            })
            //            }
        }
//        .padding(.top, 30)
//        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    AddNewTaskButton(isShowingNewTaskView: isShowingNewTaskView)
//}
