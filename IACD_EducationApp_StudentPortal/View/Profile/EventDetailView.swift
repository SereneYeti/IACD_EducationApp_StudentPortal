//
//  EventDetailView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/08/04.
//

import SwiftUI

struct EventDetailView: View {
    var brandTemp = eventIconList[0]
    var body: some View {
        VStack {
            Image("bnmBg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400, height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
            Text(brandTemp.eventTitle)
                .font(.system(size: 35))
                .bold()
                .background(
                    BlurBG(style: .systemUltraThinMaterial)
                        .frame(width: 330, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                )
                .offset(y:-30)
            Spacer()
            
                Text(brandTemp.eventBody)
                    .font(.body)
                .padding(.bottom,100)
            
            
            Spacer()
                
        }
        .ignoresSafeArea(.all)
      
    }
        
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView()
    }
}
