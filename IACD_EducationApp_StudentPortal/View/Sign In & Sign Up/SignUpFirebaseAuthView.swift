//
//  SignUpFirebaseAuthView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/13.
//

import SwiftUI


import SwiftUI

struct SignUpFirebaseAuthView: View {
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
            .navigationTitle("Sign Up")
        }        
    }
}

struct SignUpFirebaseAuthView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFirebaseAuthView().environmentObject(AppViewModel())
    }
}
