//
//  ClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/26.
//

import SwiftUI


//TODO: LIST
//      - ADD WAY FOR USER TO JOIN CLUBS
//      - Make club view look nice
//TODO: ENDLIST
struct ClubView: View {
    @State var club:Clubs
    
    var body: some View {
        VStack{
            HStack{
                Text("Club Coordinator: \(club.Coordinator!)")
                //Image() //TODO: Add images of club coordinators, nb do in circle like the example
            }
            Divider()
            Text("Club Description: \(club.ClubDescription!)")
        }
        .navigationTitle(club.id!)
    }
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        ClubView(club: Clubs(id: "", Coordinator: "", ClubDescription: "", Helpful_Information: [], Meetups: [], RequiredEquipment: [], forumID: -1, members: []))
    }
}
