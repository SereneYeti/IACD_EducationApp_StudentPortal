//
//  HomeView.swift
//  JvieyraSwiftUITestBed
//
//  Created by IACD-011 on 2022/06/02.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var showWelcomeScreen: Bool = false
    @State private var showMapView: Bool = false
    @State private var showCalendarView: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading){
                    Spacer()
                    
                    Text("This is the Home View!")
                    
                    CurrentModulesView()
                        .frame(height:100)
                    
                    UpcomingProjectsView()
                        .frame(height:200)
                        .onTapGesture {
                            showCalendarView = true
                        }
                }
            }
            .navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .sheet(isPresented: $showWelcomeScreen, content: {onboarding() })
            .sheet(isPresented: $showMapView, content: {  MapView() })
            .sheet(isPresented: $showCalendarView, content: { CalendarView() })
        }.onAppear{
            print("View Model Sign In: \(viewModel.firstTimeSignIn)")
            showWelcomeScreen = viewModel.firstTimeSignIn
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppViewModel())
    }
}

