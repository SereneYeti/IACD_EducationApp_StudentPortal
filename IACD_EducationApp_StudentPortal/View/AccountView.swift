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
        HStack{
            Text("User signed in")
            
            Spacer()
            
            Button(action:{
                if viewModel.signedIn {
                    viewModel.signOut()
                    
                }
            }){
                Text("Sign out")
                    .foregroundColor(Color.white)
                    .frame(width: 100, height: 50)
                    .cornerRadius(8)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
