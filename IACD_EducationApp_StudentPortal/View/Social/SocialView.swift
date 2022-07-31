//
//  SocialView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/27.
//

import SwiftUI

struct SocialView: View {
    @ObservedObject var forumsViewModel =  ChatroomsViewModel()
    
    init(){
        forumsViewModel.fetchData()
    }
    
    var body: some View {
        VStack(spacing: 1){
            //Text("My Clubs")
              //  .font(.title)
                //.bold()
                //.frame(width: screen.width, height: screen.height*0.05, alignment: .center)
            
            ClubCardsView().environmentObject(forumsViewModel)
                .frame(width: screen.width, height: screen.height*0.28)
                .background(.white)
                .padding()
                //.navigationTitle("My Clubs")
            
            Divider()
                .frame(height:2)
                .overlay(.indigo)
                .opacity(0.3)            
            
            ChatroomListView().environmentObject(forumsViewModel)
                .frame(width: screen.width)
                .background(.white)
                .padding()
              }
        //.navigationBarHidden(true)
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
