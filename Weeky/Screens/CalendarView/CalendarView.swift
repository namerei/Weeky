//
//  CalendarView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

//MARK: - My versions
struct CalendarView: View {
    @Binding var isCalendarViewShowed : Bool
    @Binding var date : Date
    
    @State var isShowingNewTaskView = false
    
    var body: some View {
        VStack {
            BackwordArrow(isCalendarViewShowed: $isCalendarViewShowed, isShowingNewTaskView: $isShowingNewTaskView)
            if !isShowingNewTaskView {
                VStack {
                    DatePicker("j", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    Spacer()
                    NewTaskButton()
                }
            } else {
                VStack {
                    NewTaskView()
                }
            }
        }
    }
    
    func NewTaskButton()->some View {
        Button(action: {
            withAnimation {
                isShowingNewTaskView.toggle()
            }
        }, label: {
            Text("New Task")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        })
        .padding(50)
    }
}


struct BackwordArrow: View {
    @Binding var isCalendarViewShowed: Bool
    @Binding var isShowingNewTaskView: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.smooth) {
                    withAnimation {
                        if isShowingNewTaskView {
                            isShowingNewTaskView.toggle()
                        } else {
                            isCalendarViewShowed.toggle()
                        }
                    }
                }
            }, label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15, height: 15)
                    .foregroundColor(.black)
                Spacer()
            })
        }
        .padding(30)
    }
}

