//
//  AccountView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/19.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View{
        Button(action:{
            print("signing out")
            if viewModel.signedIn {
                viewModel.unbind()
                viewModel.signOut()
                
            }
        }){
            Text("Sign out")
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
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
