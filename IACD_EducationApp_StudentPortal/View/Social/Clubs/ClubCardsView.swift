//
//  ClubCardsView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/27.
//

import SwiftUI

struct ClubCardsView: View {
    @State var clubID:String?
    @State var clubDescription:String?
    //@Binding var clubs:[Clubs]
    @ObservedObject var viewModel =  ClubsViewModel()
    
    init() {
        //
        //viewModel.joinClub(clubID: "Mountain Biking")
        
        viewModel.fetchUserClubs()
        
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                //ForEach(0 ..< viewModel.clubs.count) { index in
                    //ClubCardView()
                Text("Club")
                //}
            }
        }
    }
}

struct ClubCardView:View{
    @State var club:Clubs
    
    var body: some View{
        Text("Club card")
            .background(.red)
    }
}

struct ClubCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubCardsView()
        //ClubCardView()
    }
}
