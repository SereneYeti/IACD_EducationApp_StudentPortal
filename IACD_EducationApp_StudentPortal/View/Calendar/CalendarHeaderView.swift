//
//  CalendarHeaderView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/13.
//

import SwiftUI

struct CalendarHeaderView: View {
    var body: some View {
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 15) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
            
        }
        .padding()
        .padding(.top, getSafeArea().top)
        .background(Color.white)
    }
    
}

struct CalendarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHeaderView()
    }
}
