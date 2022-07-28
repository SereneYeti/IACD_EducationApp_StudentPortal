//
//  ClassesCardView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/25.
//

import SwiftUI

struct ClassesCardListView: View {
    @State var previewModule : Module = .sample
    @ObservedObject var moduleViewModel : ModuleViewModule
    var body: some View {
        
        VStack(spacing: 30){
            ClassesCardListView(moduleViewModel: moduleViewModel)
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
        ClassesCardListView(moduleViewModel: ModuleViewModule())
    }
}

struct ClassTaskCardView: View{
    @EnvironmentObject var moduleViewModel : ModuleViewModule
    var body: some View{
        ForEach(moduleViewModel.modules){ item in
            ForEach(item.tasks!, id:\.self) { tasks in
                VStack(spacing: 10) {
                    HStack {
                        VStack {
                            Text(tasks.taskTitle ?? "")
                                .font(.system(size: 16, weight: .bold))
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                        }
                        Spacer()
                    }
                    .padding(20)
                    HStack{
                        Spacer()
                        Text("Module")
                        Text(item.name ?? "")
                            .bold()

                    }
                    .padding()
                }
                .padding(.top,30)
                .frame(width: screen.width - 50, height: screen.width - 250)
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color(hex: item.color ??  "000000"), radius: 1, x: 2, y: 2)
                .shadow(color: Color(hex: item.color ??  "000000"), radius: 1, x: 2, y: 2)
    
            }
        }
    }
}
