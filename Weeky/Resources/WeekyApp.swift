//
//  WeekyApp.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.12.2023.
//

import SwiftUI
import FirebaseCore

@main
struct WeekyApp: App {
    //register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(viewModel)
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
    @StateObject var viewModel = HomeViewModel()
//    @EnvironmentObject var viewModel:  HomeViewModel

    var body: some View {
        Group{
            
//            AuthorizationView()
//            HomeView()
            
            if viewModel.authorized {
                HomeView()
                    .environmentObject(viewModel)
            }else {
                AuthorizationView()
            }
        }
    }
}
