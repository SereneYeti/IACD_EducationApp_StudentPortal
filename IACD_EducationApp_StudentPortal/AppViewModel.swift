//
//  AppViewModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/11.
//

import SwiftUI
import FirebaseAuth

class AppViewModel:ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn:Bool  {
        return auth.currentUser != nil
    }
    
    func signIn(email:String, password:String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.signedIn = true
                print("Sign In successfull...")
            }
        }
    }
    
    func signUp(email:String, password:String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.signedIn = true
                print("Sign Up successfull...")
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
}

