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
            ZStack{
                
                Color.indigo.ignoresSafeArea(.all)
                
                VStack{
                    Text("📚")
                        .font(.system(size: 200))
                    NavigationLink(destination: SignUpFirebaseAuthView()) {
                        Text("Sign Up")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.horizontal, 60)
                            .padding(.vertical, 15)
                            .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .padding()
                    
                    Divider()
                    
                    NavigationLink(destination: SignInFirebaseAuthView()) {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.horizontal, 60)
                            .padding(.vertical, 15)
                            .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .padding()
                }
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
