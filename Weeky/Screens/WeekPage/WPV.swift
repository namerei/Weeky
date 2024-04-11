//
//  WeekPageView.swift
//  Weeky
//
//  Created by namerei on 11.04.24.
//

import SwiftUI

struct WeekPageView: View {
    //@StateObject var taskModel = WeekPageViewModel()
//    @Namespace var animation
    @State var isShowingSideMenu = false
    @State private var isCalendarViewShowed = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HeaderView(isShowingSideMenu: $isShowingSideMenu, isCalendarViewShowed: $isCalendarViewShowed)
                    WeekView()
                    MainScrollView()
                }
            }
            SideMenu(isShowingSideMenu: $isShowingSideMenu)
        }
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


struct HeaderView: View {
    @Binding var isShowingSideMenu: Bool
    @Binding var isCalendarViewShowed: Bool
    
    var body: some View {
        HStack(spacing: 10){
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
        }
        .padding()
        .background(Color.white)
    }
}

struct MainScrollView: View {
    var body: some View {
        //    func MainScrollView()-> some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("1")
            Text("1")
            Text("1")
            //Lazy with pinned header
        }
    }
}


struct DateTitleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
//            Text(Date().formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
            Text(Date().formatted(date: .abbreviated, time: .omitted)).font(.title2)
//            Text("Today").font(.title.bold())
        }
        //        .hLeading()
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
        }
    }
}

