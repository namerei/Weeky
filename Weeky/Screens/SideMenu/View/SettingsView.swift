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
    @State private var language = false
    @State private var selectedDayIndex = 0
    @State private var isShowingAccountView = false
    @State var isShowingSuccessView = false
    @State private var error = "Пустые поля"
    
    @State private var name = ""
    @State private var password = ""
    
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
                    ChangeUserData()
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
                        
                        Toggle(isOn: $language) {
                            Text("Изменить язык (ru/en)")
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

    }
    
    
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
    
    func ChangeUserData()->some View {
        VStack {
            VStack{
                HStack(spacing: 15){
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("Blue light"))
                    TextField("Изменить имя пользователя", text: $name)
                }
                
                Divider().background(Color.white.opacity(0.6))
            }
            .padding(.horizontal)
            .padding(.top, 40)
            
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "eye.slash.fill")
                        .foregroundColor(Color("Blue light"))
                    SecureField("Изменить пароль", text: $password)
                }
                
                Divider()
                    .background(Color.white.opacity(0.6))
            } .padding(.horizontal)
                .padding(.top, 50)
            
            AcceptButton()
            
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
    }
    
    func AcceptButton()->some View {
        VStack {
        if !isShowingSuccessView {
            Button(action: {
                if name != "" || password != "" {
                    //MARK: - update Data
                    error = ""
                    withAnimation {
                        isShowingSuccessView = true
                        name = ""
                        password = ""
                    }
                }
                isShowingSuccessView = true
            }, label: {
                Text("Внести изменения")
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                    .padding()
//                    .padding(.horizontal, 50)
//                    .background(Color("Yellow xlight"))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
//                    .offset(y: 25)
            })
        } else {
            SuccessView(text: "Пользователь создан!", error: error)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            isShowingSuccessView = false
                        }
                    }
                }
        }
        }
    }
}


//struct SuccessView: View {
//    @State var text: String
//    @State var error: String
//
//    init(text: String, error: String) {
//        self.error = error
//        self.text = text
//    }
//
//    var body: some View {
//        error == "" ? Text(text) : Text(error)
//            .font(.title)
//            .foregroundColor(error != "" ? .red : .blue)
//    }
//}

