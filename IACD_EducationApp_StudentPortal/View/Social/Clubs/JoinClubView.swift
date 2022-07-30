//
//  JoinClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/28.
//

import SwiftUI

struct JoinClubView: View {
    @EnvironmentObject var viewModel:ClubsViewModel
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
                //viewModel.GetAllClubs()
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
        JoinClubView(club: nil)
    }
}
