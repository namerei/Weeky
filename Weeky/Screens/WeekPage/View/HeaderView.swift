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


struct DateTitleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
//            Text(Date().formatted(date: .abbreviated, time: .omitted)).foregroundColor(.gray)
            Text(Date().formatted(date: .abbreviated, time: .omitted)).font(.title2)
//            Text("Today").font(.title.bold())
        }
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
        .sheet(isPresented: $isCalendarViewShowed, content: {
            CalendarView(isCalendarViewShowed: $isCalendarViewShowed, date: $date)
        })
    }
    
}


struct ShowSideMenuButton: View {
    @Binding var isShowingSideMenu : Bool
    
    var body: some View {
        NavigationLink(destination: SettingsView().transition(.scale), label: {
            Image(systemName: "list.bullet")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
        })
    }
}

//#Preview(body: {
//    HeaderView()
//})
