//
//  WeekPageView.swift
//  Weeky
//
//  Created by namerei on 11.04.24.
//

import SwiftUI

struct WeekPageView: View {
    @StateObject var taskModel = WeekPageViewModel()
    //    @Namespace var animation
    @State var isShowingSideMenu = false
    @State private var isCalendarViewShowed = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HeaderView(isShowingSideMenu: $isShowingSideMenu, isCalendarViewShowed: $isCalendarViewShowed)
                    //                    WeekView()
//                    TaskView()
                    MainScrollView()
                }
            }
            SideMenu(isShowingSideMenu: $isShowingSideMenu)
        }
    }
    
    
    func MainScrollView()->some View {
        //        var body: some View {
        //    func MainScrollView()-> some View {
        ScrollView(.vertical, showsIndicators: false) {
            WeekView()
            
            VStack(spacing: 18){
                if let tasks = taskModel.filteredTasks{
                    if tasks.isEmpty{
                        Text("No Tasks Found!!!")
                            .font(.system(size: 16))
                            .fontWeight(.light)
                        //                        .offset(y: 100)
                    }else{
                        ForEach(tasks){ task in
                            TaskCardView(task: task)
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
            .padding()
            .padding(.top)
        }
        //            TaskCardView(task: Task(id: nil, taskTitle: "kjdkf", taskDescription: "lkjdfkgj", taskDate: nil))
        //Lazy with pinned header
    }
//}

    func TaskCardView(task: Task)->some View{
        HStack(alignment: .top, spacing: 30){
            VStack(spacing: 10){
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
                
            }
            VStack{
                HStack(alignment: .top, spacing: 10){
                    VStack(alignment: .leading, spacing: 12){
                        Text(task.taskTitle)
                            .font(.title2.bold())
                        Text(task.taskDescription)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .hLeading()
                    
                    Text(task.taskDate.formatted(date: .omitted, time: .shortened))
                }
                
                if taskModel.isCurrentHour(date: task.taskDate){
                    HStack(spacing: 0){
                        HStack(spacing: -10){
                            ForEach(["Profile","Profile","Profile"], id: \.self){ user in
                                Image(user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .stroke(.black, lineWidth: 5)
                                    )
                            }
                        }
                        .hLeading()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.black)
                                .padding(10)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.top)
                }
            }
            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate) ? .white : .black)
            .padding()
            .hLeading()
            .background(
                Color(.black)
                    .cornerRadius(25)
            )
        }.hLeading()
    }
}


#Preview {
    WeekPageView()
}



//MARK: - Views
struct SideMenu: View {
    @Binding var isShowingSideMenu: Bool
    let mindarg : CGFloat = 100
    
    var body: some View {
        SideMenuView()
            .offset(x: isShowingSideMenu ? 0 : -270)
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let shouldShow = value.translation.width > self.mindarg
                        withAnimation {
                            isShowingSideMenu = shouldShow
                        }
                    })
            )
    }
}


struct WeekView: View {
    @StateObject var taskModel = WeekPageViewModel()
    @Namespace var animation
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10){
                ForEach(taskModel.currentWeek,id: \.self){ day in
                    VStack(spacing: 10){
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
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                            }
                        })
                    .contentShape(Capsule())
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





