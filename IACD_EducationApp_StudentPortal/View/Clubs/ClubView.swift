//
//  ClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/26.
//

import SwiftUI


//TODO: LIST
//      - FIND CLUBS WHERE FIELD INCLUDES USER STUDENT NO
//      - ADD WAY FOR USER TO JOIN CLUBS
//      - DISPLAY USER CLUBS
//      - DISPLAY SELECTED CLUB INFO
//      - Create enum of clubs for queries
//TODO: ENDLIST
struct ClubView: View {
    @ObservedObject var viewModel =  ClubsViewModel()
    
    init() {
        viewModel.fetchData(clubID: "Rock Climbing")
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        ClubView()
    }
}
