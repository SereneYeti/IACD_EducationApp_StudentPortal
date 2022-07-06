//
//  SignInFirebaseAuthView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/06.
//

import SwiftUI

struct SignInFirebaseAuthView: View {
    @State var email = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Image("")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack{
                    TextField("Email Address", text:  $email)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    TextField("Password", text:  $email)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                }
                .padding()
            }
            .navigationTitle("Sign in")
        }
        
    }
}

struct SignInFirebaseAuthView_Previews: PreviewProvider {
    static var previews: some View {
        SignInFirebaseAuthView()
            
    }
}
