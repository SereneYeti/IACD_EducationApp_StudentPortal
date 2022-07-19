//
//  UpcomingProjectsView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/14.
//

import SwiftUI

struct UpcomingProjectsView: View {
    var body: some View {
        VStack{
            Text("Upcoming Tasks")
                .font(.title)
                .padding()
            
            HStack{
                Text("1...")
                
                Spacer()
                
                Text("2...")
            }
            
            Spacer()
            
            HStack{
                Text("3...")
                
                Spacer()
                
                Text("4...")
                
                Spacer()
                
                Text("6...")
            }
            
            Spacer()
            
            HStack{
                Text("7...")
                
                Spacer()
                
                Text("8...")
                
            }
        }
        .padding()
        .background(.blue)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
              
    }
}

struct UpcomingProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingProjectsView()
    }
}