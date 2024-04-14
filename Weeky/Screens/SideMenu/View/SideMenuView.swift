//
//  SideMenuView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

import SwiftUI

/*
struct SideMenuView: View {
//    @Binding var sideMenuParameters : SideMenuParameters
//    var newPassword = String()
    @State var editData = false
    
    var body: some View {
        ScrollView {
            Spacer()
            VStack {
                Text("Acount:")
                    .font(.title)
                if !editData {
                    Button("изменить данные", action: {
                        withAnimation(.smooth) {
                            editData.toggle()
                        }
                    })
                    .font(.title2)
                }
                else {
                    AccauntSettings()
                }
            }
            Divider()
//            Spacer()
//            VStack {
//            Text("Темная тема / светлая тема")
//            Spacer()
//            Text("Уведомления")
            
            VStack {
                Text("Темная тема / светлая тема")
                Text("Уведомления")
                Text("день недели")
            }
            
//                Toggle("Switch", isOn: $sideMenuParameters.darkThemeIsOn)
//                    .padding()
//                    .toggleStyle(SwitchToggleStyle(tint: .blue)) // Можно настроить стиль переключателя
//                
//                Text(sideMenuParameters.darkThemeIsOn ? "Enabled" : "Disabled")
//                    .padding()
//            }
            Divider()
            
        }
    }
    
    func AccauntSettings()->some View {
        VStack {
            ZStack {
                VStack {
                    Spacer()
                    Text("изменить логин")
                        .font(.title2)
                    Text("изменить пароль")
                        .font(.title2)
                    Spacer()
                    Button(action: {
                        withAnimation(.smooth) {
                            editData.toggle()
                        }
                    }, label: {
                        Image(systemName: "сохранить")
                            .foregroundColor(.blue)
                            .font(.system(size: 24))
                    })
                    //                    Divider()
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            withAnimation(.smooth) {
                                editData.toggle()
                            }
                        }, label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(.gray)
                                .font(.system(size: 24))
                        })
                        Spacer()
                    }
                }
            }
            Button("Выйти из аккаунта", action: {
                print("ВЫйти")
            })
            .foregroundColor(.red)
        }
    }
}
*/


struct SettingsView: View {
    @State private var darkModeOn = false
    @State private var notificationsOn = false
    @State private var selectedDayIndex = 0
    let daysOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Логин")
                        .font(.title)
                    Text("Имя")
                        .font(.subheadline)
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
                // Logout action
            }) {
                Text("Выйти из аккаунта")
                    .foregroundColor(.red)
            }
//            .padding()
//        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
