//
//  WeekyApp.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.12.2023.
//

import SwiftUI
//import FirebaseCore

@main
struct WeekyApp: App {
    @StateObject var viewModel = HomeViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            //                FirebaseApp.configure()
            @StateObject var taskModel = HomeViewModel()
            
            
            return true
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel:  HomeViewModel

    var body: some View {
        Group{
            
//            AuthorizationView()
//            HomeView()
            
            if viewModel.authorized {
                HomeView()
            }else {
                AuthorizationView()
            }
        }
    }
}
