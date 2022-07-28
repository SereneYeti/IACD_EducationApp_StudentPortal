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
    @ObservedObject var viewModel =  ClubsViewModel()
    
    init() {
        viewModel.GetAllClubs()
    }
    
    var body: some View {
        
        ScrollView {
            HStack{
               
                ForEach(viewModel.allClubs) { club in
                    ClubCardView(club: club)
                    Text(club.Coordinator!)
                        .background(.red)
                    
                }
            }
            .onAppear{
                
                print("CLubssss: \(viewModel.allClubs.count)")
            }
        }
        
    }
}

struct ClubCardView:View{
    @State var club:Clubs
    
    var body: some View{
        VStack{
            Text("Coordinator: \(club.Coordinator!)")
            Text("CDescription: \(club.ClubDescription!)")
        }
    }
}

struct ClubCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubCardsView()
        //ClubCardView()
    }
}
