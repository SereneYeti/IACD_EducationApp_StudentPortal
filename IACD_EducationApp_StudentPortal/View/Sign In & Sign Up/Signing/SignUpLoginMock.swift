    //
    //  SignUpLoginMock.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/08/03.
    //

import SwiftUI

struct SignUpLoginMock: View {
    @State var userName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordReEnter: String = ""
    @State var testStu = testData[0]
    
    @EnvironmentObject var viewModel:AppViewModel
    
    
    fileprivate func btnSignUp() {
        
        viewModel.signUp(email: email, password: password)
        
        if(viewModel.signedIn)
        {
            print("Loading Home Page Now...")
            email = ""
            password = ""
            //ContentView()
        }
        else
        {print("An error occured.")}
    }
    
   
    
    var body: some View {
        
            //MARK: Sign Up
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Sign up")
                        .font(.system(size: 45))
                        .bold()
                    Text("Create a new account")
                }
                Spacer()
                Image("logo1")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .blendMode(.colorBurn)
              
                    
            }
            .padding(.bottom,30)
            .padding([.leading,.trailing])
            Rectangle()
                .frame(width: 300, height: 1)
                .foregroundColor(.secondary)
                .padding(.bottom,50)
            
            VStack(spacing: 20){
                    //MARK: Username
                TextField("", text: $userName)
                    .padding()
                    .placeholder(when: userName.isEmpty) {
                        Text("Enter Username")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .background(Color(hex: "f8f9fa").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                    //MARK: Email
                TextField("", text: $email)
                    .padding()
                    .placeholder(when: email.isEmpty) {
                        Text("Enter Email")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .background(Color(hex: "f8f9fa").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                    //MARK: Password
                SecureField("", text: $password)
                    .padding()
                    .placeholder(when: password.isEmpty) {
                        Text("Enter Password")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .background(Color(hex: "f8f9fa").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                    //MARK: Re-enter
                SecureField("", text: $passwordReEnter)
                    .padding()
                    .placeholder(when: passwordReEnter.isEmpty) {
                        Text("Re-Enter Password")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .background(Color(hex: "f8f9fa").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .padding(.bottom,40)
            .padding([.leading,.trailing], 2)
            
            Rectangle()
                .frame(width: 300, height: 1)
                .foregroundColor(.secondary)
            
            Text("By signing in your accept the terms and services which may or may not exsist")
                .font(.footnote)
                .foregroundColor(.black.opacity(0.7))
                .padding()
            
            Button {
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                
                if(password == passwordReEnter){
                    self.btnSignUp()
                }
                
                testStu.firstName = userName
                
            } label: {
                Text("Sign Up")
                    .tint(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .frame(width: 350, height: 50)
                            .foregroundColor(Color(hex: "f8f9fa").opacity(0.9))
                            .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 1)
                            .shadow(color: .white, radius: 1, x: -1, y: -1)
                    )
                   
            }
            .padding()
            
        }
        .background(
            BlurBG(style: .systemUltraThinMaterial)
                .frame(width: 380, height: 680)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        )
        .padding()
        .background(
            Image("bg2")
        )
    }
        
}

struct SignUpLoginMock_Previews: PreviewProvider {
    static var previews: some View {
        SignUpLoginMock()
    }
}
