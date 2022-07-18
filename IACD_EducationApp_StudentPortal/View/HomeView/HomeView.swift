//
//  HomeView.swift
//  JvieyraSwiftUITestBed
//
//  Created by IACD-011 on 2022/06/02.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var enlargeMapScreen:Bool = false;
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading){
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
                                .background(Color.blue)
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    Text("This is the Home View!")
                    
                    CurrentModulesView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: 100)
                        
                    
                    UpcomingProjectsView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: 200)
                    
                    Text("Map View: ")
                    
                    MapView()
                        .frame(height:250)
                        .onTapGesture {
                            enlargeMapScreen = true; }
                }
            }
            .navigationBarHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            .navigationTitle("Home")
            .sheet(isPresented: $enlargeMapScreen, content: { MapView() })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppViewModel())
    }
}

