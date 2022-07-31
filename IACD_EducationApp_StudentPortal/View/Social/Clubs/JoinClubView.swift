//
//  JoinClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/28.
//

import SwiftUI

struct JoinClubView: View {
    @Binding var isOpen:Bool
    @EnvironmentObject var viewModel:ClubsViewModel
    @EnvironmentObject var forumsViewModel:ChatroomsViewModel
    @State var club:Clubs?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack
        {
            Text(club!.id!)
                .font(.headline)
                .padding()
            Button {
                viewModel.joinClub(clubID: club!.id!)  
                print("joining with code \(club!.forumID!)")
                forumsViewModel.joinChatroom(code: club!.forumID!, handler: {
                    self.isOpen = false
                })
                //JoinClubsView().mode.wrappedValue.dismiss()
                //self.mode.wrappedValue.dismiss()
                print("Joined club: \(club!.id!)")
                
            } label: {
                Text("Join Club")
                    .padding(2)
                    .background(.blue)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                
            }
            .padding()

        }
    }
}

struct JoinClubView_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubView(isOpen: .constant(true),club: nil)
    }
}
