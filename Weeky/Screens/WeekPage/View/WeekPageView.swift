//
//  WeekPageView.swift
//  Weeky
//
//  Created by namerei on 11.04.24.
//

import SwiftUI

struct WeekPageView: View {
    @StateObject var taskModel = WeekPageViewModel()
    @Namespace var animation
    
    @State private var isShowingSideMenu = false
    @State private var isCalendarViewShowed = false
    @State private var isShowingNewTaskView = false
    
    var body: some View {
//        NavigationView {
        NavigationView {
            ZStack {
                MainVStack()
                AddNewTaskButtonView()
            }
        }
    }
    
    //MARK: - Views
    private func MainVStack()->some View {
        VStack {
            HeaderView(isShowingSideMenu: $isShowingSideMenu, isCalendarViewShowed: $isCalendarViewShowed)
            MainScrollView()
        }
    }
    
    private func AddNewTaskButtonView()-> some View {
        HStack {
//            QuoteVStack()
            Spacer()
            VStack {
                Spacer()
                AddNewTaskButton(isShowingNewTaskView: $isShowingNewTaskView)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: -5, y: 5)
                    .padding(20)
            }
        }
    }
    
    func QuoteVStack()->some View {
        var qouet = "Что разум человека может постигнуть и во что он может поверить, того он способен достичь"
        var author = "Наполеон Хилл"
        
        return VStack {
            Spacer()
            VStack {
                Text(qouet)
                    .font(.footnote)
                    .foregroundColor(Color(.white))
            }
                .background(Color(.gray))
                .frame(height: 90)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                .cornerRadius(30)
                .padding(20)
        }
    }
    
    func MainScrollView()->some View {
        ScrollView(.vertical, showsIndicators: false) {
            WeekView()
            
            VStack(spacing: 5){
                if let tasks = taskModel.filteredTasks{
                    if tasks.isEmpty{
                        Text("No Tasks Found!!!")
                            .font(.system(size: 16))
                            .fontWeight(.light)

                    }else{
                        ForEach(tasks){ task in
                            TaskCardView(taskTitle: task.taskTitle, taskTime: "16:20")
                        }
                    }
                }else{
                    //Mark: Progress View
                    ProgressView()
                        .offset(y: 100)
                }
            }
            //Updating Task
            .onChange(of: taskModel.currentDay){ newValue in
                taskModel.filteringTodayTask()
            }
//            .padding()
//            .padding(.top)
        }
        //            TaskCardView(task: Task(id: nil, taskTitle: "kjdkf", taskDescription: "lkjdfkgj", taskDate: nil))
        //Lazy with pinned header
    }
    //}
    
    
    func WeekView()->some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10){
                ForEach(taskModel.currentWeek,id: \.self){ day in
                    VStack(spacing: 5){
                        Text(taskModel.extractDate(date: day, format: "dd"))
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                        
                        Text(taskModel.extractDate(date: day, format: "EEE"))
                            .font(.system(size: 14))
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 8, height: 8)
                            .opacity(taskModel.isToday(date: day) ? 1 : 0)
                    }
                    .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                    .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                    .frame(width: 45, height: 90)
                    .background(
                        ZStack{
                            if taskModel.isToday(date: day){
                                Capsule()
                                    .fill(Color("Blue dark"))
                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                            }
                        })
                    //                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation{
                            taskModel.currentDay = day
                        }
                    }
                }
            }
        }
    }
}

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


#Preview {
    WeekPageView()
}

