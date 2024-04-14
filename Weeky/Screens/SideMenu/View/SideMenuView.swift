//
//  SideMenuView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

import SwiftUI

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
