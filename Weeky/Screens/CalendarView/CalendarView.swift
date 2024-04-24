//
//  CalendarView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

//MARK: - My versions
struct CalendarView: View {
    @EnvironmentObject var viewModel : HomeViewModel
    @Binding var isCalendarViewShowed : Bool
    
    @State var isShowingNewTaskView = false
    
    var body: some View {
        VStack {
            BackwordArrow(isCalendarViewShowed: $isCalendarViewShowed, isShowingNewTaskView: $isShowingNewTaskView)
            if !isShowingNewTaskView {
                VStack {
                    DatePicker("j", selection: $viewModel.currentDay)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .foregroundColor(.black)
                        .accentColor(Colors.textList)
                    Divider()
                    MiniTaskScrollView()
                    Divider()
                    NewTaskButton()
                }
            } else {
                VStack {
                    NewTaskView(dateFromCalendar: $viewModel.currentDay)
                        .offset(y: -30)
                }
            }
        }
        .background(Colors.background)
        .foregroundColor(Colors.textHeader)
    }
    
    func NewTaskButton()->some View {
        Button(action: {
            withAnimation {
                isShowingNewTaskView.toggle()
            }
        }, label: {
            Text("Новая задача")
                .padding()
                .frame(maxWidth: .infinity)
//                .foregroundColor(.white)
                .background(Colors.yellow)
                .foregroundColor(.black)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: -5, y: 5)
        })
        .padding(30)
    }
    
    func MiniTaskScrollView()->some View {
        ScrollView(showsIndicators: false) {
            let tasks = viewModel.allTaskInDay(viewModel.currentDay)
            if !tasks.isEmpty {
                ForEach(tasks) { task in
//                    Text(task.title)
                    MiniTaskScrollViewCell(task)
                }
            } else {
                Text("Задачи не найдены")
                    .foregroundColor(.gray)
            }
        }
    }
    
    func MiniTaskScrollViewCell(_ task: Task)->some View {
        HStack {
            Circle()
                .fill(Color(task.colorName))
                .frame(width: 20, height: 20)
            Text(task.title)
            Spacer()
            if let date = task.dateString.toDate() {
                Text("\(date.showOnlyTimeString())")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
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
        .padding(.horizontal, 15)
    }
}


struct BackwordArrow: View {
    @Binding var isCalendarViewShowed: Bool
    @Binding var isShowingNewTaskView: Bool
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.smooth) {
                    withAnimation {
                        if isShowingNewTaskView {
                            isShowingNewTaskView.toggle()
                        } else {
                            viewModel.backTodayIfNeeded()
                            isCalendarViewShowed.toggle()
                        }
                    }
                }
            }, label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15, height: 15)
                Spacer()
            })
        }
        .foregroundColor(Colors.textHeader)
        .padding(30)
    }
}

