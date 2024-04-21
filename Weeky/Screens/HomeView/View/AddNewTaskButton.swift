//
//  AddNewTaskButton.swift
//  Weeky
//
//  Created by namerei on 11.04.24.
//

import SwiftUI

struct AddNewTaskButton: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var isShowingNewTaskView: Bool
//    @State var date = Date()
    
    var body: some View {
        Button {
            print("button add new task")
            isShowingNewTaskView.toggle()
        } label: {
            Label { Text("") } icon: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(width: 90, height: 90)
                    .background(Color("Yellow light"))
                    .clipShape(Circle())
            }
            .sheet(isPresented: $isShowingNewTaskView, content: {
                NewTaskView(dateFromCalendar: $viewModel.currentDay)
            })
//            .background(Color("Blue xlight").edgesIgnoringSafeArea(.all))
        }
    }
}

//#Preview {
//    AddNewTaskButton(isShowingNewTaskView: isShowingNewTaskView)
//}
