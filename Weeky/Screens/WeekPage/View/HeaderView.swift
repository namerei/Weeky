//
//  HeaderView.swift
//  Weeky
//
//  Created by namerei on 11.04.24.
//

import SwiftUI

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

//struct CustomNavigationLink<Label: View, Destination: View>: View {
//    
//    let destination: Destination
//    let label: Label
//    @State private var isActive = false
//    
//    var body: some View {
//        Button(action: {
//            isActive = true
//        }) {
//            label
//        }
//        .background(
//            NavigationLink(
//                destination: destination,
//                isActive: $isActive,
//                label: { EmptyView() }
//            ).hidden()
//        )
//    }
//    
//    
//}


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
    @State var date = Date()
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
            CalendarView(isCalendarViewShowed: $isCalendarViewShowed, date: $date)
        })
    }
    
}


struct ShowSideMenuButton: View {
    @Binding var isShowingSideMenu : Bool
    
    var body: some View {
//        ZStack {
//            Button(action: {
//                withAnimation {
//                    isShowingSideMenu = true
//                }
//            }, label: {
//                Image(systemName: "list.bullet")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 25, height: 25)
//                    .foregroundColor(.black)
//            })
////            .sheet(isPresented: $isShowingSideMenu, content: {
////                MySideMenuView()
////                SideMenuView()
////            })
//            .fullScreenCover(isPresented: $isShowingSideMenu, content: {
//                withAnimation(nil) {
//                    SideMenuView()
//                }
////                    .interactiveDismissDisabled(true)
//            })
//        }
        
        
//        withAnimation(nil) {
//            NavigationLink("Войти", destination: SideMenuView())
//                .foregroundColor(Color("Gray"))
//            //                .fontWeight(.bold)
//                .padding(.vertical)
//                .padding(.horizontal, 50)
//                .background(Color("Yellow xlight"))
//                .clipShape(Capsule())
//                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
//            
//                .offset(y: 25)
//        }
        NavigationLink(destination: SettingsView().transition(.scale), label: {
            Image(systemName: "list.bullet")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
        })
//        .transition(.scale)
    }
}

//#Preview(body: {
//    HeaderView()
//})
