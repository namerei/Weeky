//
//  WeekPageView.swift
//  TODOList3
//
//  Created by user on 11/11/23.
//

import SwiftUI

//struct WeekPageView: View {
//
//    @ObservedObject var viewModel = WeekPageViewModel()
//    @State var name = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//
//              Text("Список задач")
//              .padding(.all, 30)
//              .foregroundColor(Color("Blue dark"))
//              .font(.system(.title, design: .monospaced))
//
//
//                TextField("Новая задача", text: $name)
//                .padding(.all)
//                    .onSubmit {
//                        viewModel.add(name: name)
//                        name = ""
//
//                    }
//                    .border(Color("Orange dark"))
//                    .frame(width: 360, height: 20)
//                    .background(Color("Yellow xlight"))
//                    .padding(.bottom, 20)
//
//
//                List {
//                    ForEach(viewModel.items) { item in
//                        HStack {
//                            Text(item.name)
//                            Spacer()
//                            Button {
//                                viewModel.completeItem(item: item)
//                            } label: {
//                                Image(systemName: item.isCompleted ? "checkmark" : "square")
//                                .foregroundColor(Color("Blue dark"))
//
//                            }
//                            .background(Color("Yellow xlight"))
//
//
//                        }
//
//                    }
//                    .onDelete(perform: viewModel.delete(index:))
//                }
//
//            }
//
//
//            .background(Color("Yellow xlight"))
//
//        }
//    }
//}


//MARK: - new
struct WeekPageView: View {
    @StateObject var taskModel = WeekPageViewModel()
    @Namespace var animation
    @State var isShowingSideMenu = false
    @State private var isCalendarViewShowed = false
    let mindarg : CGFloat = 100
    
    var body: some View {
            ZStack {
                NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    //Lazy with pinned header
                    LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]){
                        Section {
                            //Week View
                            ScrollView(.horizontal, showsIndicators: false){
                                
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
                                            }
                                        )
                                        .contentShape(Capsule())
                                        .onTapGesture {
                                            withAnimation{
                                                taskModel.currentDay = day
                                            }
                                        }
                                    }
                                }
                                TasksView()
                            }
                        } header: {
                            HeaderView()
                        }
                    }
                    
                }
                //MARK: - hide side menu
                .onTapGesture {
                    withAnimation {
                        isShowingSideMenu = false
                    }
                }
                .ignoresSafeArea(.container, edges: .top)
                }
                
                SideMenuView()
                    .offset(x: isShowingSideMenu ? 0 : -270)
                //MARK: - swipe side menu
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                let shoulsShow = value.translation.width > self.mindarg
                                withAnimation {
                                    isShowingSideMenu = shoulsShow
                                }
                            })
                    )
                //            .navigationBarItems(leading:
                //                                    Button(action: {
                //                isShowingSideMenu.toggle()
                //            }, label: {
                //                Image(systemName: "line.horizontal.3")
                //                    .imageScale(.large)
                //            })
                //            )
//            .navigationTitle("Home")
        }
        
        //MARK: - end of scrollView
    }
    
    func TasksView()-> some View{
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
    
    
    
    //MARK: - Views
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
    
    func HeaderView()-> some View{
        HStack(spacing: 10){
            //            Spacer()
            ShowSideMenuButton(isShowingSideMenu: $isShowingSideMenu)
                .onTapGesture {
                    withAnimation {
                        isShowingSideMenu = true
                    }
                }
            
            Spacer()
            DateTitleView()
            Spacer()
            ShowCalendarButton(isCalendarViewShowed: $isCalendarViewShowed)
            //            Spacer()
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
}


#Preview {
    WeekPageView()
}


//MARK: - Views
struct DateTitleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            //            Text(Date().formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
            Text(Date().formatted(date: .abbreviated, time: .omitted)).font(.title)
            
            //            Text("Today").font(.largeTitle.bold())
        }.hLeading()
    }
}

struct ShowCalendarButton: View {
    @Binding var isCalendarViewShowed: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isCalendarViewShowed.toggle()
            }
        }, label: {
            Image(systemName: "calendar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
        })
        //        .fullScreenCover(isPresented: $isShowingSideMenu, content: {
        .sheet(isPresented: $isCalendarViewShowed, content: {
            CalendarView(isCalendarViewShowed: $isCalendarViewShowed)
        })
        
    }
    
}

struct ShowSideMenuButton: View {
    @Binding var isShowingSideMenu : Bool
    
    
    var body: some View {
        ZStack {
            Button(action: {
                withAnimation {
                    isShowingSideMenu = true
                }
            }, label: {
                Image(systemName: "list.bullet")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.black)
            })
            //        .fullScreenCover(isPresented: $isShowingSideMenu, content: {
            //        .sheet(isPresented: $isShowingSideMenu, content: {
            //            SideMenuView(isShowingSideMenu: $isShowingSideMenu)
            //        })
            
        }
        
        
        
    }
    //    }
}
