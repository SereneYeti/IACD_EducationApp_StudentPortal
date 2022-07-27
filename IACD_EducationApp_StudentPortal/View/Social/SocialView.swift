//
//  SocialView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/27.
//

import SwiftUI

struct SocialView: View {
    var body: some View {
        VStack{
            ClubCardsView()
                .frame(width: screen.width, height: screen.height*0.25)
                .background(.white)
                .padding()
            
            Divider()
                .foregroundColor(.black)
            
            ChatroomListView()
                .frame(width: screen.width)
                .background(.white)
                .padding()
        }
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
