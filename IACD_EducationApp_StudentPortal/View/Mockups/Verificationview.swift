//
//  Verificationview.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/08/03.
//

import SwiftUI

struct Verificationview: View {
    @State var verificationText: String = ""
    @State var verifiedStatus: Bool = true
    @Binding var profileClicked: Bool
    var body: some View {
        
        VStack{
            HStack {
                VStack(alignment: .leading) {
                    Text("Student Name")
                        .font(.system(size: 35))
                        .bold()
                }
                .overlay(
                Image(systemName: "person.fill")
                    .resizable()
                    .offset(y:-90)
                    .frame(width: 80, height: 80)
                    .blendMode(.colorBurn)
                )
            }
            .offset(y:30)
            .padding(.bottom,30)
            .padding([.leading,.trailing])
            //MARK: Verify
            if !verifiedStatus {
                VStack {
              
                
                TextField("", text: $verificationText)
                    .padding()
                    .placeholder(when: verificationText.isEmpty) {
                        Text("Enter Degree Code")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .background(Color(hex: "f8f9fa").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding()
                Button {
                    //MARK: Verify Action
                    verifiedStatus.toggle()
                } label: {
                    Text("Verify Degree Code")
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
            } else {
                EmptyView()
            }
            Button {
                //MARK: Sign Out Action
            } label: {
                Text("Sign Out")
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
            
            Button {
                self.profileClicked.toggle()
            } label: {
                Image(systemName: "x.circle.fill")
                    .font(.system(size: 35, weight: .black))
                    .tint(.black)
                    .offset(y:50)
            }

                
        }
        .background(
            BlurBG(style: .systemUltraThinMaterial)
                .frame(width: 370, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        )
        .padding()
        .background(
            BlurBG(style: .systemUltraThinMaterialDark)
                .frame(width: screen.width, height: screen.height)
                .ignoresSafeArea(.all)
        )
    }
}

struct Verificationview_Previews: PreviewProvider {
    static var previews: some View {
        Verificationview(profileClicked: .constant(true))
    }
}
