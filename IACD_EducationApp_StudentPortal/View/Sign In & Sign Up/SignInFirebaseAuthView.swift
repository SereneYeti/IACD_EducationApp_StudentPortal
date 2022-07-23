//
//  SignInFirebaseAuthView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/06.
//

import SwiftUI

struct SignInFirebaseAuthView: View {
    @EnvironmentObject var viewModel:AppViewModel
    
    @State var email = ""
    @State var pass = ""
    
    
    
    
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
            ZStack{
                Color.purple.ignoresSafeArea(.all)
                
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
                            .frame(width: 350, height: 50)
                            .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                        
                        SecureField("Password", text:  $pass)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .frame(width: 350, height: 50)
                            .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .font(.system(size: 13, weight: .bold, design: .rounded))
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
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .padding(.horizontal, 60)
                                    .padding(.vertical, 15)
                                    .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                        }
                        else{
                            Text("Sign In")
                                .foregroundColor(Color.white)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
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
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .padding(.horizontal, 60)
                                    .padding(.vertical, 15)
                                    .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                        }
                        else{
                            Text("Sign Up")
                                .foregroundColor(Color.white)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                    .padding()
                    
                }
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
        StartView().environmentObject(AppViewModel())
        SignInFirebaseAuthView().environmentObject(AppViewModel())
        
    }
}

