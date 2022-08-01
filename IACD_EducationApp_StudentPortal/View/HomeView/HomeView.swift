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
    @State private var showNewsletter: Bool = false
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
                    HStack{
                        VStack{
                    NavigationLink(destination: MapView()) {
                        //MapView()
                        Image("Image")
                            .resizable()
                        //added
                            
                            .aspectRatio(contentMode: .fill)
                       //     .frame(width: screen.width, height: 200)
                            .frame(width: 150, height: 150)
                            //.padding()
                        
                    }
                    .background(.purple)
                    .cornerRadius(20)
                    .padding(.init(top: 20, leading: 30, bottom: 0, trailing: 10))
                    .onTapGesture {
                        print("Tapped on Map")
                        //showMap = true
                    }
                            Text("Map")
                                .padding(.bottom, 30)
                    }
                        VStack{
                    NavigationLink(destination: CalendarView()) {
                        //MapView()
                        Image("calendar1")
                            .resizable()
                        //added
                            
                            .aspectRatio(contentMode: .fill)
                       //     .frame(width: screen.width, height: 200)
                            .frame(width: 150, height: 150)
                            //.padding(.top , 10)
                        
                    }
                    .background(.purple)
                    .cornerRadius(20)
                    .padding(.init(top: 20, leading: 10, bottom: 0, trailing: 20))
                    .onTapGesture {
                        print("Tapped on Map")
                        //showMap = true
                    }
                            Text("Calendar")
                                .padding(.bottom, 30)
                    }
                        .padding(.horizontal)
                    }
                
                    VStack (alignment: .leading, spacing: 10){
                        Image("News")
                            .resizable()
                            .cornerRadius(20)
                            .frame(width: 350, height: 100)
                      
                        Text("Stay up to date")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text("This is the latest news and infromation regarding Vega University. Find out when the Important dates are.")
                            .font(Font.system(size:14, design: .default))
                            .foregroundColor(.white)
                        
                        Capsule()
                            .foregroundColor(Color.white)
                            .frame(height: 44)
                            .overlay(Text("Read more"))
                            .padding()
                            .onTapGesture {
                                showNewsletter = true
                            }
                    }
                    .padding()
                    .background(Color.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.horizontal, 10)
                    
           
                }
            }
            .navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .ignoresSafeArea(edges: .top)
            .sheet(isPresented: $showWelcomeScreen, content: {onboarding() })
            .sheet(isPresented: $showMap, content: {MapView() })
            .sheet(isPresented: $showCalendarView, content: { CalendarView() })
            .sheet(isPresented: $showNewsletter, content: {Newsletter() })
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

