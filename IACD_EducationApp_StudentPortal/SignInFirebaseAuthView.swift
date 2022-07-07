//
//  SignInFirebaseAuthView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/06.
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

struct StartView: View {
    @EnvironmentObject var viewModel:AppViewModel
    
    var body: some View{
        NavigationView{
            if viewModel.signedIn{
                ContentView()
            }
            else
            {
                SignInFirebaseAuthView()
            }
        }
    }
}

struct SignInFirebaseAuthView: View {
    @State var email = ""
    @State var pass = ""
        
    @EnvironmentObject var viewModel:AppViewModel
    
    
    fileprivate func btnSignUp() {
        
        viewModel.signUp(email: email, password: pass)
        
        if(viewModel.signedIn)
            {
            print("Loading Home Page Now...")
            email = ""
            pass = ""
        }
        else
            {print("An error occured.")}
    }
    
    fileprivate func btnSignIn(){
        
        viewModel.signIn(email: email, password: pass)
                
        if(viewModel.signedIn)
            {
            print("Loading Home Page Now...")
            email = ""
            pass = ""
        }
        else
            {print("An error occured.")}
       
        
        
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack{
                    TextField("Email Address", text:  $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Password", text:  $pass)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                }
                .padding()
                Button(action: {
                    
                    guard !email.isEmpty, !pass.isEmpty else {
                        return
                    }
                    
                    btnSignIn()
                }) {
                    if(viewModel.signedIn){
                        NavigationLink(destination: ContentView()) {
                            Text("Sign In")
                                .foregroundColor(Color.white)
                                .frame(width: 200, height: 50)
                                .cornerRadius(8)
                                .background(Color.blue)
                        }
                    }
                    else{
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    }
                    
                }
                .padding()
                
                //Spacer()
                Divider()
                
                Button(action: {
                    //code
                    guard !email.isEmpty, !pass.isEmpty else {
                        return
                    }
                    
                    btnSignUp()
                }) {
                    if(viewModel.signedIn){
                        NavigationLink(destination: ContentView()) {
                            Text("Sign Up")
                                .foregroundColor(Color.white)
                                .frame(width: 200, height: 50)
                                .cornerRadius(8)
                                .background(Color.blue)
                        }
                    }
                    else{
                        Text("Sign Up")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    }
                }
                .padding()

            }
            .navigationTitle("Sign in")
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}
    
struct SignInFirebaseAuthView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
        SignInFirebaseAuthView()
            
    }
}

