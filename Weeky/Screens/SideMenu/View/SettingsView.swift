//
//  SettingsView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

//struct CustomToggleStyle: ToggleStyle {
//    var color: Color
//    
//    func makeBody(configuration: Configuration) -> some View {
//        Button {
//            configuration.isOn.toggle()
//        } label: {
//            HStack {
//                configuration.label
//                    .foregroundColor(color)
//                Spacer()
//                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
//                    .foregroundColor(color)
//            }
//        }
//    }
//}

struct SettingsView: View {
    @EnvironmentObject var viewModel : HomeViewModel
    
//    @State private var darkModeOn = false
    @State private var notificationsOn = false
    @State private var language = false
    @State private var selectedDayIndex = 0
    @State private var isShowingAccountView = false
    @State private var isShowingSuccessView = false
    @State private var error = "Пустые поля"
    
    @State private var name = ""
    @State private var password = ""
    
    @Binding var isAuthorized : Bool
    
    let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    
    var body: some View {
        NavigationView {
            VStack {
                MainListView()
                LogoutButton()
            }
        }
        .foregroundColor(Color(.black))
        .navigationBarTitle("Настройки", displayMode: .large)
        
    }
    
    //MARK: - Views
    func MainListView()->some View {
        List {
//            VStack {
                HStack {
                    //                    Image(systemName: "person.circle")
                    //                        .resizable()
                    //                        .frame(width: 50, height: 50)
                    //                                Text("\(viewModel.currentUser?.name ?? "_")")
                    //                                    .font(.title)
                    Text("Аккаунт")
                    Spacer()
                    Image(systemName: "chevron.forward")
//                    ForwardArrow()
                }
                .onTapGesture {
                    print("TAP")
                }
//                .onTapGesture {
//                    self.selectedItem = item
//                    // Здесь можно выполнить нужное действие при выборе элемента
//                    print("Selected item: \(item)")
//                }
//                Divider()
                //                    .padding()
                
                Toggle(isOn: withAnimation {$viewModel.isDarkMode}) {
                    Text("Темная тема")
                }
//                .toggleStyle(SwitchToggleStyle(tint: Color("Blue dark")))
//                Divider()
                //                    .padding()
                
                Toggle(isOn: $notificationsOn) {
                    Text("Уведомления")
                }
//                .toggleStyle(SwitchToggleStyle(tint: Color("Blue dark")))
//                Divider()
                //                    .padding()
                
                Toggle(isOn: $language) {
                    Text("Изменить язык (ru/en)")
                }
//                .toggleStyle(SwitchToggleStyle(tint: Color("Blue dark")))
//                Divider()
                //                    .padding()
                
                //                    HStack {
                //                        Text("День начала недели")
                //                            .padding()
//                Spacer()
                Picker(selection: $selectedDayIndex, label: Text("День начала недели")) {
                    ForEach(0..<daysOfWeek.count) { index in
                        Text(daysOfWeek[index])
                    }
                }
//                .foregroundColor(Color("Blue xlight"))
                .pickerStyle(DefaultPickerStyle())
            }
            //                .padding()
//        }
//        .disabled(true)
//        .listStyle(InsetListStyle())
    }
    
    func LogoutButton()->some View {
        Button(action: {
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
//                Image(systemName: !isShowingAccountView ? "chevron.forward" : "x.circle" )
                Image(systemName: "chevron.forward")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
//                Spacer()
            })
        }
        .padding(30)
    }
    
    func ChangeUserData()->some View {
        VStack {
//            VStack{
//                HStack(spacing: 15){
//                    Image(systemName: "person.fill")
//                        .foregroundColor(Color("Blue light"))
//                    TextField("Изменить имя пользователя", text: $name)
//                }
//                
//                Divider().background(Color.white.opacity(0.6))
//            }
//            .padding(.horizontal)
//            .padding(.top, 40)
            
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
                
//                viewModel.currentUser = nil
//                viewModel.storedTasks.removeAll()
                
//                viewModel.
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
                        viewModel.updatePassword( password)
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
                        .clipShape(Capsule())
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                        .offset(y: 25)
                })
            } else {
                SuccessView(text: "Данные изменены", error: error)
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
                        
struct Previews: PreviewProvider {
    
//    struct Container: View {
    static var previews: some View {
        @State var show = true
        //        @State var cityName = "Мончегорск"
        
//        var body: some View {
            //            DestinationSearchView(show: $show, cityName: $cityName)
            SettingsView(isAuthorized: $show)
        }
//    }
}
