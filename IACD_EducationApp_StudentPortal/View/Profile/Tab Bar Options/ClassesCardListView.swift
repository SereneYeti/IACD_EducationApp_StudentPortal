//
//  ClassesCardView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/25.
//

import SwiftUI

struct ClassesCardListView: View {
    @State var previewModule : Module = .sample
    var body: some View {
        
        VStack(spacing: 30){
            ClassCardView(previewModule: previewModule)
                .frame(width: screen.width - 50, height: screen.width - 250)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color(hex: previewModule.color ??  "000000"), radius: 1, x: 2, y: 2)
                .shadow(color: Color(hex: previewModule.color ??  "000000").opacity(0.5), radius: 8, x: 2, y: 2)
        }
    }
}


struct ClassesCardView_Previews: PreviewProvider {
    static var previews: some View {
        ClassesCardListView()
    }
}

struct ClassCardView: View{
    @State var previewModule : Module = .sample
    var body: some View{
        ForEach(previewModule.content ?? [], id: \.self){ conTitle in
            VStack {
                HStack {
                    VStack{
                        Text(conTitle.contentTitle ?? "")
                            .font(.system(size: 16, weight: .bold))
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                    }
                    Spacer()
                }
                .padding(20)
                HStack{
                    Spacer()
                    Text("Lecturer")
                    Text(previewModule.lecturer ?? "")
                        .bold()

                }
                .padding()
            }
        }
        
    }
}
