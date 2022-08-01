    //
    //  ModulesCardView.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/07/24.
    //

import SwiftUI

struct ModulesCardView: View {
    @State var previewModule : Module = .sample
    var body: some View {
        ZStack {
            CardView(previewModule: previewModule)
                .frame(width: screen.width - 40, height: screen.width - 220)
                .background(Color(hex: previewModule.color ??  "000000"))
                .overlay {

                    AsyncImage(url: URL(string: previewModule.image ?? "")) { image in
                        image.image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .blendMode(.colorBurn)
                    }
                    .offset(x: 80, y: 40)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color(hex: previewModule.color ??  "000000"), radius: 20, x: 5, y: 5)
        }
    }
}

struct ModulesCardView_Previews: PreviewProvider {
    static var previews: some View {
        ModulesCardView(previewModule: .sample)
            //            .previewLayout(.sizeThatFits)
        
    }
}

struct CardView: View{
   @State var previewModule  : Module = .sample
    var body: some View{
        VStack {
            HStack {
                VStack{
                    Text(previewModule.name ?? "")
                        .font(.system(size: 18, weight: .bold))
                        Spacer()
                }
                Spacer()
            }
            .padding(20)
            HStack{
                Text("Lecturer")
                Text(previewModule.lecturer ?? "")
                    .bold()
                Spacer()
            }
            .padding()
        }
    }
}
