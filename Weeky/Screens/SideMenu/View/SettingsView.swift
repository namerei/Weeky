//
//  SettingsView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var viewModel : HomeViewModel
    
//    @State private var darkModeOn = false
    @State private var notificationsOn = false
    @State private var language = false
    @State private var selectedDayIndex = 0
    @State private var isShowingAccountView = false

    
    @Binding var isAuthorized : Bool
    
    let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    
    var body: some View {
        VStack {
            MainListView()
//                .background(Colors.background0)
//            Spacer()
            LogoutButton()
        }
        .foregroundColor(Color(.black))
        .background(Colors.background0)
//        .background(Colors.background0)
        .navigationBarTitle("Настройки", displayMode: .large)
    }
    
    //MARK: - Views
    func MainListView()->some View {
        ZStack {
            List {
                NavigationLink(destination: AccountView(isAuthorized: $isAuthorized)) {
                    Text("Аккаунт")
                }
                .listRowBackground(Colors.background1)
                
                CustomToggle(text: "Темная тема",binding: $viewModel.isDarkMode)
                CustomToggle(text: "Уведомления",binding: $notificationsOn)
                CustomToggle(text: "Изменить язык ru/en",binding: $isShowingAccountView)
                
                Picker(selection: $selectedDayIndex, label: Text("День начала недели")) {
                    ForEach(0..<daysOfWeek.count) { index in
                        Text(daysOfWeek[index])
                    }
                }
                .listRowBackground(Colors.background1)
                .pickerStyle(DefaultPickerStyle())
//                .frame(height: 400)
            }
            .listStyle(InsetGroupedListStyle())
            .padding(.vertical, 20)
            .background() // Цвет фона списка
            .cornerRadius(30)
            .padding()
//            .background(Colors.background0)
        }
        .background(Colors.background0)
        .foregroundColor(Colors.text0)
    }
    
    //MARK: - Views
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
        }
    }
    
    func CustomToggle(text: String, binding: Binding<Bool> )->some View {
        Toggle(isOn: binding) {
            Text(text)
        }
        .listRowBackground(Colors.background1)
        .toggleStyle(SwitchToggleStyle(tint: Color("Blue light")))
    }
}

struct Previews: PreviewProvider {
    
    static var previews: some View {
        @State var show = true
        
        SettingsView(isAuthorized: $show)
    }
}
