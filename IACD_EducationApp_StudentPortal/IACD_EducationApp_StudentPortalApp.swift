    //
    //  IACD_EducationApp_StudentPortalApp.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-011 on 2022/06/22.

    ///
    ///    let persistenceController = PersistenceController.shared


    ///
    //
import SwiftUI
import Firebase

@main
struct IACD_EducationApp_StudentPortalApp: App {
    
        // register app delegate for Firebase setup
    //@StateObject var fireStoreManager = StudentModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared
    
    /*init(){
        FirebaseApp.configure()
    }*/
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            StartView()
               .environmentObject(viewModel)
//
//            MapView()
//                .environmentObject(viewModel)
                
                           
            //ProfileView()
              //  .environmentObject(fireStoreManager)
            
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}
