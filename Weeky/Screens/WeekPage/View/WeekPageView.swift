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
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
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
        .ignoresSafeArea(.container, edges: .top)
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
            VStack(alignment: .leading, spacing: 10){
                Text(Date().formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
                
                Text("Today").font(.largeTitle.bold())
            }.hLeading()
            
            Button{
                
            } label: {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeekPageView()
                .previewInterfaceOrientation(.portrait)
            WeekPageView()
        }
    }
}

extension View{
    func hLeading()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    //Safe Area
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}



#Preview {
    WeekPageView()
}
