//
//  TasksDetailView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/31.
//

import SwiftUI

struct TasksDetailView: View {
    var previewModule : Module
    var previewTasks: Tasks
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader{ reader in
                AsyncImage(url: URL(string: previewModule.image ?? ""  )) { image in
                    if reader.frame(in: .global).minY > -480 {
                        image
                        .resizable()
                        .background(.white)
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY)
                        //MARK: Parallax effect
                        .frame(width: UIScreen.main.bounds.width,
                           height: reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480)
                    }
                } placeholder: {
                    ProgressView()
                }
            }
            //MARK: Frame size
            .frame(height: 480)
            VStack(alignment: .center, spacing: 15) {
                Text(previewTasks.taskTitle ?? "")
                    .font(.system(size: 30, weight: .bold))
                
                Text(previewTasks.taskBody ?? "")
                    .font(.callout)
                    .padding()
            }
            .padding(.top)
            .padding(.horizontal)
            .background(BlurBG(style: .systemMaterial))
            .cornerRadius(20)
            .offset(y: -75)
            .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(hex: previewModule.color ?? "").edgesIgnoringSafeArea(.all))
    }
}

struct TasksDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TasksDetailView(previewModule: .sample, previewTasks: .sample)
    }
}
