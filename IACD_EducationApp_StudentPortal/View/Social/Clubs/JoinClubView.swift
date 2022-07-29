//
//  JoinClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/28.
//

import SwiftUI

struct JoinClubView: View {
    @State var club:Clubs?
    
    var body: some View {
        Text(club!.id!)
    }
}

struct JoinClubView_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubView(club: nil)
    }
}
