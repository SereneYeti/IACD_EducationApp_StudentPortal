//
//  ImgView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/08/02.
//

import SwiftUI

struct ImgView:View{
    var URL:String
    var credit:String
    
    init(URL:String,credit:String) {
        self.URL = URL
        self.credit = credit
    }
    var body: some View{
        VStack{
            Divider()
                .frame(height: 0.5)
                .overlay(.indigo)
                .opacity(0.3)
            
            Text("Image taken by \(credit)")
                .font(.caption)
                .fontWeight(.light)
                .padding()
                .alignmentGuide(HorizontalAlignment.leading) { _ in
                    0
                }
            
            AsyncImage(url: Foundation.URL(string: URL)) { image in
                image.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .gray, radius: 8, x: 0, y: 0)
                    .padding()
                
            } placeholder: {
                ProgressView()
            }
            
        }
    }
}

