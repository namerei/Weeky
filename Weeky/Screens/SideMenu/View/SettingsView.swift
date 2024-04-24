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
            HeaderView()
            MainListView()
            LogoutButton()
        }
//        .foregroundColor(Color(.black))
        .background(Colors.background)
//        .navigationBarTitle("Настройки", displayMode: .large)
    }
    
    //MARK: - Views
    func MainListView()->some View {
//        VStack {
            
            ScrollView {
                VStack {
                NavigationLink(destination: AccountView(isAuthorized: $isAuthorized)) {
                    HStack {
                        Text("Аккаунт")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                .padding(20)
                Divider()
                .background(Colors.dividerGray)

                CustomToggle(text: "Темная тема",binding: $viewModel.isDarkMode)
                        
                CustomToggle(text: "Уведомления",binding: $notificationsOn)
                        
                CustomToggle(text: "Изменить язык ru/en",binding: $isShowingAccountView)
                        
                DatePickerView()
                }
                .background(Colors.backgroundList)
                .cornerRadius(30)
                .padding()
            }
//        }
//        .background(Colors.background)
        .foregroundColor(Colors.textList)
    }
    
    //MARK: - Views
    private func HeaderView()->some View {
        HStack {
            Text("Настройки")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Colors.textHeader)
            Spacer()
            Image(systemName: "gear")
                .font(.title)
                .foregroundColor(.black)
        }
        .padding()
        .frame(width: 400, height: 60)
        .background(Colors.header)
    }
    
    private func LogoutButton()->some View {
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
    
    private func CustomToggle(text: String, binding: Binding<Bool> )->some View {
        VStack {
            Toggle(isOn: binding) {
                Text(text)
            }
//            .listRowBackground(Colors.backgroundList)
            .toggleStyle(SwitchToggleStyle(tint: Color("Blue light")))
            .padding()
            Divider()
                .background(Colors.dividerGray)
        }
    }
    
    private func DatePickerView()->some View {
        HStack {
            Text("День начала недели")
                .padding()
            Spacer()
            Picker(selection: $selectedDayIndex, label: Text("")) {
                ForEach(0..<daysOfWeek.count) { index in
                    Text(daysOfWeek[index])
                }
            }
        }
        .padding(.vertical, 10)
    }
}


struct Previews: PreviewProvider {
    
    static var previews: some View {
        @State var show = true
        
        SettingsView(isAuthorized: $show)
    }
}
