//
//  UserInfoMock.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/08/03.
//

import SwiftUI

struct UserInfoMock: View {
    var contactTypes = ["Home","Emergency","Personal"]
    @State var selectedContact: String = "Home"
    
    var sexTypes = ["Male","Female"]
    @State var selectedSex: String = "Male"
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var contactNumber: String = ""
    @State var passwordReEnter: String = ""
    var body: some View {
        
            //MARK: Sign Up
        VStack {
            HStack {
                VStack(alignment: .leading,spacing: 10) {
                    Text("Info")
                        .font(.system(size: 45))
                        .bold()
                    Text("Enter Personal Information")
                        
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
                    //MARK: first Name
                TextField("", text: $firstName)
                    .padding()
                    .placeholder(when: firstName.isEmpty) {
                        Text("Enter First Name")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .background(Color(hex: "f8f9fa").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                    //MARK: Last name
                TextField("", text: $lastName)
                    .padding()
                    .placeholder(when: lastName.isEmpty) {
                        Text("Enter Last Name")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .background(Color(hex: "f8f9fa").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                    //MARK: Sex Selected
                HStack {
                    TextField("", text: $selectedSex)
                        .padding()
                        .placeholder(when: selectedSex.isEmpty) {
                            Text("Select a Sex")
                                .foregroundColor(.black)
                                .padding()
                        }
                        .background(Color(hex: "f8f9fa").opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    Picker("Type",selection: $selectedSex){
                        ForEach(sexTypes, id:\.self){
                            Text($0)
                        }
                        .pickerStyle(.wheel)
                    }
                    .frame(width: 180, height: 55)
                    .background(Color(hex: "000814").opacity(0.6))
                 
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    
                }
                
                    //MARK: Contact Info
                HStack {
                    TextField("", text: $contactNumber)
                        .padding()
                        .placeholder(when: contactNumber.isEmpty) {
                            Text("Enter a Contact")
                                .foregroundColor(.black)
                                .padding()
                        }
                        .background(Color(hex: "f8f9fa").opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    Picker("Type",selection: $selectedContact){
                        ForEach(contactTypes, id:\.self){
                            Text($0)
                        }
                        .pickerStyle(.wheel)
                    }
                    .frame(width: 80, height: 55)
                    .background(Color(hex: "000814").opacity(0.6))
                 
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    
                }
                
        
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

struct UserInfoMock_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoMock()
    }
}
