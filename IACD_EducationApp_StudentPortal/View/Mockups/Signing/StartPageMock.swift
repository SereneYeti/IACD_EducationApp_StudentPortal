//
//  StartPageMock.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/08/03.
//

import SwiftUI

struct StartPageMock: View {
    @State var email: String = ""
    @State var password: String = ""
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
            Rectangle()
                .frame(width: 300, height: 1)
                .foregroundColor(.secondary)
                .padding(.bottom,20)
            
            
            Button {
                
            } label: {
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
            
            Button {
                
            } label: {
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
            
        }
        .background(
            BlurBG(style: .systemUltraThinMaterial)
                .frame(width: 380, height: 320)
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
    }
}
