//
//  SettingsView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel : HomeViewModel
    
    @State private var darkModeOn = false
    @State private var notificationsOn = false
    @State private var selectedDayIndex = 0
    @State private var isShowingAccountView = false
    
    @Binding var isAuthorized : Bool
    
    let daysOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    var body: some View {
//        if !isShowingAccountView {
            ScrollView {
                if isShowingAccountView {
                    Spacer()
                }
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("\(viewModel.currentUser?.name ?? "_")")
                            .font(.title)
                        Text("имя пользователя")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    ForwardArrow()
                }
                .padding()
                
                if isShowingAccountView {
                    Divider()
                    
                    VStack {
                        Button(action: {
                            // Change password
                        }) {
                            Text("Изменить имя")
                        }
                        .padding()
                        
                        Button(action: {
                            // Change username
                        }) {
                            Text("Изменить пароль")
                        }
                        .padding()
                        
                        Button(action: {
                            //MARK: - back to authorization View
                            viewModel.currentUser = nil
                            viewModel.storedTasks.removeAll()
                            withAnimation {
                                isAuthorized = false
                            }
                        }) {
                            Text("Выйти из аккаунта")
                                .foregroundColor(.red)
                        }
                        .padding()
                    }
                    Divider()
                        .padding()
                } else {
                    
                    VStack {
                        Toggle(isOn: $darkModeOn) {
                            Text("Темная тема")
                        }
                        .padding()
                        
                        Toggle(isOn: $notificationsOn) {
                            Text("Уведомления")
                        }
                        .padding()
                        
                        
                        HStack {
                            Text("День начала недели")
                                .padding()
                            Spacer()
                            Picker(selection: $selectedDayIndex, label: Text("Выберите день")) {
                                ForEach(0..<daysOfWeek.count) { index in
                                    Text(daysOfWeek[index])
                                }
                            }
                            .padding()
                        }
                        //                .pickerStyle(WheelPickerStyle())
                        .pickerStyle(DefaultPickerStyle())
                    }
                    //                .padding()
                }
                
                if !isShowingAccountView {
                    Spacer()
                }
            }
        if !isShowingAccountView {
            Button(action: {
                //MARK: - back to authorization View
                viewModel.currentUser = nil
                viewModel.storedTasks.removeAll()
                withAnimation {
                    isAuthorized = false
                }
            }) {
                Text("Выйти из аккаунта")
                    .foregroundColor(.red)
                //                if isShowingAccountView {
                //                    Spacer()
                //                }
            }
        }
//        }
//        else {
//            AccountView()
//        }
    }
    
//    func AccountView()->some View {
//        VStack {
//            HStack {
//                Image(systemName: "person.circle")
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                VStack(alignment: .leading) {
//                    Text("\(viewModel.currentUser?.name ?? "_")")
//                        .font(.title)
//                    Text("имя пользователя")
//                        .font(.footnote)
//                        .foregroundColor(.gray)
//                }
//                ForwardArrow()
//            }
//            .padding()
//            
//            Divider()
//            
//            VStack {
//                Button(action: {
//                    // Change password
//                }) {
//                    Text("Изменить имя")
//                }
//                .padding()
//                
//                Button(action: {
//                    // Change username
//                }) {
//                    Text("Изменить пароль")
//                }
//            }
//            Divider()
//                .padding()
//        }
//    }
    
    func ForwardArrow()->some View {
//        Spacer()
        HStack {
            Button(action: {
                withAnimation(.smooth) {
                    withAnimation {
                        isShowingAccountView.toggle()
                    }
                }
            }, label: {
                Image(systemName: !isShowingAccountView ? "chevron.forward" : "x.circle" )
//                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
//                Spacer()
            })
        }
        .padding(30)
    }
}



