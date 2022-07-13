//
//  SignInSignUpChoiceView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/13.
//

import SwiftUI

struct SignInSignUpChoiceView: View {
    @EnvironmentObject var viewModel:AppViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                Text("📚")
                    .font(.title)
                    .scaledToFill()
                    .padding()
                NavigationLink(destination: SignUpFirebaseAuthView()) {
                    Text("Sign Up")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                }
                .padding()
                
                Divider()
                
                NavigationLink(destination: SignInFirebaseAuthView()) {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                }
                .padding()
            }
        }
    }
}

struct SignInSignUpChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        SignInSignUpChoiceView().environmentObject(AppViewModel())
        StartView().environmentObject(AppViewModel())
    }
}
