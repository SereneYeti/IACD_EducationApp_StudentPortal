//
//  IACD_EducationApp_StudentPortalApp.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/06/22.
//
import SwiftUI
import Firebase

/*
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}*/

@main
struct IACD_EducationApp_StudentPortalApp: App {
    
    
    init() {
        FirebaseApp.configure()
    }
    // register app delegate for Firebase setup
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
