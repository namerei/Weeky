//
//  WeekyApp.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.12.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct WeekyApp: App {
    //register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            
            return true
        }
    }
}

struct ContentView: View {
    @StateObject var authorizationViewModel = AuthorizationViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    
    @State var isAuthorized = false

    var body: some View {
        Group{
            if isAuthorized {
                HomeView(isAuthorized: $isAuthorized)
                    .environmentObject(homeViewModel)
                    .onAppear {
                        homeViewModel.addUser(authorizationViewModel.user ?? User())
                    }
            } else {
                AuthorizationView(isAuthorized: $isAuthorized)
                    .environmentObject(authorizationViewModel)
//                    .onReceive(authorizationViewModel.$currentUser) { user in
//                        homeViewModel.currentUser = user
//                    }
            }
        }
    }
}
