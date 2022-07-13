//
//  HomeView.swift
//  JvieyraSwiftUITestBed
//
//  Created by IACD-011 on 2022/06/02.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("User signed in")
                    
                    Button(action:{
                        if viewModel.signedIn {
                            viewModel.signOut()
                            
                        }
                    }){                        
                        Text("Sign out")
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    }
                    .padding()
                }
                
                Spacer()
                
                Text("This is the Home View!")
            }
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppViewModel())
    }
}

