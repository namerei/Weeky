//
//  TaskView.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 11.04.24.
//

import SwiftUI

//struct TaskView: View {
////    @Binding var taskModel: WeekPageViewModel
//    
//    @StateObject var taskModel = WeekPageViewModel()
//    
//    var body: some View {
//        VStack(spacing: 18){
//            if let tasks = taskModel.filteredTasks{
//                if tasks.isEmpty{
//                    Text("No Tasks Found!!!")
//                        .font(.system(size: 16))
//                        .fontWeight(.light)
//                    //                        .offset(y: 100)
//                }else{
//                    ForEach(tasks){ task in
//                        TaskCardView(task: task)
//                    }
//                }
//            }else{
//                //Mark: Progress View
//                ProgressView()
//                    .offset(y: 100)
//            }
//        }
//        //Updating Task
//        .onChange(of: taskModel.currentDay){ newValue in
//            taskModel.filteringTodayTask()
//        }
//        .padding()
//        .padding(.top)
//    }
//}
//
//func TaskCardView(task: Task)->some View{
//    HStack(alignment: .top, spacing: 30){
//        VStack(spacing: 10){
//            Circle()
//                .fill(.black)
//                .frame(width: 15, height: 15)
//                .background(
//                    Circle()
//                        .stroke(.black, lineWidth: 1)
//                        .padding(-3)
//                )
//            Rectangle()
//                .fill(.black)
//                .frame(width: 3)
//            
//        }
//    }
//}
