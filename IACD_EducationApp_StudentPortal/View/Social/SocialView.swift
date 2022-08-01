//
//  SocialView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/27.
//

import SwiftUI

struct SocialView: View {
    @ObservedObject var forumsViewModel =  ChatroomsViewModel()
    @EnvironmentObject var taskModel:TaskViewModel
    
    init(){
        forumsViewModel.fetchData()
    }
    
    var body: some View {
        VStack(spacing: 1){
            //Text("My Clubs")
            //  .font(.title)
            //.bold()
            //.frame(width: screen.width, height: screen.height*0.05, alignment: .center)
            
            ClubCardsView().environmentObject(forumsViewModel).environmentObject(taskModel)
                .frame(width: screen.width, height: screen.height*0.28)
                //.background(.background)
                .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                //.ignoresSafeArea(.all, edges: .top)
                .padding()
            //.navigationTitle("My Clubs")
            
            Divider().background(Color(red: 244/255, green: 243/255, blue: 248/255))
                .frame(height:2)
                .overlay(.indigo)
                .opacity(0.7)
            
            ChatroomListView().environmentObject(forumsViewModel)
                .padding()
                .frame(width: screen.width)
                //.background(.background)
                .background(Color(red: 244/255, green: 243/255, blue: 248/255))
                .ignoresSafeArea(.all, edges: .bottom)
                
        }
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .navigationBarHidden(true)
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
