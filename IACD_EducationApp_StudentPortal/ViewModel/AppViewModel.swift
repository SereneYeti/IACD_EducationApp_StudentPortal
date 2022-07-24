//
//  AppViewModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/11.
//

import SwiftUI
import FirebaseAuth

struct User{
    var uid:String
    var email: String
}

class AppViewModel:ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var firstTimeSignIn = false;
    
    @Published var session: User?
    @Published var isAnon: Bool = false
    var handle: AuthStateDidChangeListenerHandle?
    
    
    
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
                self?.firstTimeSignIn = false;
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
                self?.firstTimeSignIn = true;
                print("Sign Up successfull...")
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
    
    func listen(){
        handle = auth.addStateDidChangeListener({(auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email!)
            }
        })
    }
    
    func unbind(){
        if let handle = handle {
            self.isAnon = false
            auth.removeStateDidChangeListener(handle)
        }
        else
        {
            self.isAnon = true
            self.session = nil
        }
    }
}

