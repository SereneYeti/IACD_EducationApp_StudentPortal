//
//  JoinClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/28.
//

import SwiftUI

struct JoinClubView: View {
    @ObservedObject var viewModel =  ClubsViewModel()
    var clubSet:[Clubs] = []
    
    init(){
        viewModel.GetAllClubs()
    }
    
    var body: some View {
        VStack{
            ForEach(0 ..< viewModel.allClubs.count){ index in
                if((index+1)<viewModel.allClubs.count){
                    ListCellView(leftClub: viewModel.allClubs[index], rightClub: viewModel.allClubs[index+1])
                }
                else
                {
                    ListCellView(leftClub: viewModel.allClubs[index], rightClub: nil)
                }
                
            }
        }
        .frame(width: screen.width, height: screen.height,alignment: .center)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("Clubs Available to Join")
    }
}

struct ListCellView:View{
    @State var leftClub:Clubs
    @State var rightClub:Clubs?
    
    var body: some View{
        HStack{
            Text(leftClub.id!)
                .frame(width: screen.width * 0.5, height: screen.height*0.15, alignment: .center)
                .background(.green)
            if(rightClub != nil){
                Text(rightClub!.id!)
                    .frame(width: screen.width * 0.5, height: screen.height*0.15, alignment: .center)
                    .background(.indigo)
            }
            else
            {
                Text("")
                    .frame(width: screen.width * 0.5, height: screen.height*0.15, alignment: .center)
                    .background(.indigo)
            }
        }
    }
}

struct JoinClubView_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubView()
    }
}
