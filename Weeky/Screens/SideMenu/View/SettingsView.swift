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
    
    @Binding var isAuthorized : Bool
    
    let daysOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("\(viewModel.currentUser?.name ?? "_")")
                        .font(.title)
//                    Text()
//                        .font(.subheadline)
                }
                //                Spacer()
            }
            .padding()
            
            Divider()
            
            VStack {
                Button(action: {
                    // Change password
                }) {
                    Text("Изменить пароль")
                }
                .padding()
                
                Button(action: {
                    // Change username
                }) {
                    Text("Изменить имя")
                }
            }
            Divider()
            //            .padding()
            
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
            Spacer()
            
            Button(action: {
                //MARK: - back to authorization View
                viewModel.currentUser = nil
                viewModel.storedTasks.removeAll()
                withAnimation {
                    isAuthorized = false
                }
                // Logout action
            }) {
                Text("Выйти из аккаунта")
                    .foregroundColor(.red)
            }
//            .padding()
//        }
    }
}

