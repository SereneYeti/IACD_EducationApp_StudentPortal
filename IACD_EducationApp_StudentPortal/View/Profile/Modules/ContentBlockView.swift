    //
    //  ContentBlockView.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/07/31.
    //

import SwiftUI

struct ContentBlockView: View {
    @ObservedObject var moduleViewModel : ModuleViewModule
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(moduleViewModel.modules){ item in
                    //MARK: Make conditional for clicked content
                    if item.name == "BnM 1A" {
                        ForEach(item.content!, id:\.self) { cons in
                            VStack{
                                Text(cons.contentTitle ?? "")
                                    .font(.system(size: 20, weight: .bold))
                                    .padding()
                            }
                            .frame(width: 200, height: 200)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .shadow(color: Color(hex: item.color ?? "").opacity(0.3), radius: 2, x: 1, y: 1)
                            .shadow(color: Color(hex: item.color ?? "").opacity(0.5), radius: 10, x: 5, y: 10)
                        }
                    } else {
                        
                    }
                }
            }
            .padding(30)
            .padding(.bottom, 30)
        }
    }
}

struct ContentBlockView_Previews: PreviewProvider {
    static var previews: some View {
        ContentBlockView(moduleViewModel: ModuleViewModule())
    }
}
