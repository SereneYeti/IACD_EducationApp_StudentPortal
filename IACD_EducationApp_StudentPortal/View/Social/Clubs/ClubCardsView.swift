//
//  ClubCardsView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/27.
//

import SwiftUI
import Foundation

struct ClubCardsView: View {
    @State var clubID:String?
    @State var clubDescription:String?
    @ObservedObject var viewModel =  ClubsViewModel()
    
    init() {
        viewModel.GetAllClubs()        
    }
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack{
                ClubCardView(club: nil)
                    .frame(width: screen.width*0.5, height: screen.height * 0.25, alignment: .center)
                    .padding()
                ForEach(viewModel.userClubs) { club in
                    ClubCardView(club: club)
                        .frame(width: screen.width*0.5, height: screen.height * 0.25, alignment: .center)
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct ClubCardView:View{
    @State var club:Clubs?
    var cornerRadius:CGFloat = 45
    
    var body: some View{
        VStack{
            if(club != nil){
                Image(systemName:"person")
                    .padding(1)
                Text("Club: \(club!.id!)")
                    .font(.headline)
                    .padding(0.5)
                Text("Coordinator: \(club!.Coordinator!)")
                    .font(.subheadline)
                    .padding(0.5)
                NavigationLink(destination: ClubView(club: self.club!)){
                    Text("More information")
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.callout)
                }
                .padding(5)
            }
            else
            {
                Image(systemName:"plus")
                    .font(.largeTitle)                    
                    .padding(1)
                Text("Join a Club")
                    .font(.headline)
                    .padding(0.5)
                NavigationLink(destination: JoinClubsView()){
                    Text("View Clubs to Join")
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.callout)
                        .padding()
                }
                .padding(5)
            }
        }
        .background(.bar)
        .cornerRadius(self.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: self.cornerRadius)
                .stroke(lineWidth: 2)
        )
    }
}

struct ClubCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubCardsView()
        //ClubCardView()
    }
}
