//
//  StartPageMock.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/08/03.
//

import SwiftUI

struct StartPageMock: View {
    @EnvironmentObject var viewModel:AppViewModel
    
    var body: some View {
        
            //MARK: Sign Up
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.system(size: 45))
                        .bold()
                }
                .overlay(
                Image("logo1")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .offset(y:-190)
                    .blendMode(.colorBurn)
                )
            }
            .padding(.bottom,30)
            .padding([.leading,.trailing])
            
            
            NavigationLink(destination: SignInMockUp().environmentObject(viewModel)){
                Text("Sign In")
                    .tint(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .frame(width: 350, height: 50)
                            .foregroundColor(Color(hex: "edf2fb").opacity(0.5))
                            .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 1)
                            .shadow(color: .white, radius: 1, x: -1, y: -1)
                    )
            }
            .padding()
            
            NavigationLink(destination: SignUpLoginMock().environmentObject(viewModel)){
                Text("Sign up")
                    .tint(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .frame(width: 350, height: 50)
                            .foregroundColor(Color(hex: "edf2fb").opacity(0.5))
                            .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 1)
                            .shadow(color: .white, radius: 1, x: -1, y: -1)
                    )

            }
            .padding()
            Rectangle()
                .frame(width: 300, height: 1)
                .foregroundColor(.secondary)
                .padding([.top,.bottom],10)
            Text("If your a new student please sign up, all returning students please sign in  ")
                .font(.footnote)
                .padding()
                .padding(.bottom)
                
        }
        .background(
            BlurBG(style: .systemUltraThinMaterial)
                .frame(width: 370, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        )
        .padding()
        .background(
            Image("bg2")
        )
    }
        
}

struct StartPageMock_Previews: PreviewProvider {
    static var previews: some View {
        StartPageMock()
            .environmentObject(AppViewModel())
            
    }
}
