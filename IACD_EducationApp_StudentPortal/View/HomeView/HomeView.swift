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
    @State private var showCalendarView: Bool = false
    @State private var showMap: Bool = false
    
    var testStu = testData[0]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading , spacing: 0){
                    
                    ZStack{
                        Image("building")
                            .resizable()
                            .ignoresSafeArea(edges: .top)
                            .aspectRatio(contentMode: .fit)
                        
                        VStack{
                            Text("Hello \(testStu.firstName)")
                                .font(.system(size: 30))
                                .foregroundColor(.purple)
                            
                            CurrentModulesView()
                                .frame(height:100)
                                .padding(.bottom)
                        }
                        
                    }
                    NavigationLink(destination: MapView()) {
                        //MapView()
                        Image("mapExample1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: screen.width, height: 200)
                            .padding()
                        
                    }
                    .background(.indigo)
                    .onTapGesture {
                        print("Tapped on Map")
                        //showMap = true
                    }
                    
                    UpcomingProjectsView()
                        .frame(height:200)
                        .onTapGesture {
                            showCalendarView = true
                        }
                    Image("newsletter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                        
                }
            }
            .navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .ignoresSafeArea(edges: .top)
            .sheet(isPresented: $showWelcomeScreen, content: {onboarding() })
            .sheet(isPresented: $showMap, content: {MapView() })
            .sheet(isPresented: $showCalendarView, content: { CalendarView() })
        }.onAppear{
            //print("View Model First Time Sign In: \(viewModel.firstTimeSignIn)")
            showWelcomeScreen = viewModel.firstTimeSignIn
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppViewModel())
    }
}

