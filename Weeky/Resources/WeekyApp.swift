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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
//            AuthorizationView()
            WeekPageView()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            //                FirebaseApp.configure()
            
            
            return true
        }
    }
}

