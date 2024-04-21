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
//        NavigationView {
        VStack {
                MainListView()
                LogoutButton()
            }
//        }
        .foregroundColor(Color(.black))
        .navigationBarTitle("Настройки", displayMode: .large)
//        .navigationBarBackButtonHidden(isShowingAccountView)
//        .navigatiobar
        
    }
    
    //MARK: - Views
    func MainListView()->some View {
        List {
//            VStack {
            
            
            NavigationLink(destination: AccountView(isAuthorized: $isAuthorized)) {
                Text("Аккаунт")
            }
            //            .onTapGesture {
//                isShowingAccountView = true
//            }
//                .onTapGesture {
//                    print("TAP")
//                }
            
                Toggle(isOn: withAnimation {$viewModel.isDarkMode}) {
                    Text("Темная тема")
                }
//                .toggleStyle(SwitchToggleStyle(tint: Color("Blue dark")))

                Toggle(isOn: $notificationsOn) {
                    Text("Уведомления")
                }
//                .toggleStyle(SwitchToggleStyle(tint: Color("Blue dark")))

                Toggle(isOn: $language) {
                    Text("Изменить язык (ru/en)")
                }
//                .toggleStyle(SwitchToggleStyle(tint: Color("Blue dark")))

                Picker(selection: $selectedDayIndex, label: Text("День начала недели")) {
                    ForEach(0..<daysOfWeek.count) { index in
                        Text(daysOfWeek[index])
                    }
                }
//                .foregroundColor(Color("Blue xlight"))
                .pickerStyle(DefaultPickerStyle())
            }
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
        }
    }
}
                        
struct Previews: PreviewProvider {
    
//    struct Container: View {
    static var previews: some View {
        @State var show = true
        
            SettingsView(isAuthorized: $show)
        }
//    }
}
