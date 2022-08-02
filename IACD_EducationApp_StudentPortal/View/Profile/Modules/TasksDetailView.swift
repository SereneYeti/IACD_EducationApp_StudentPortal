//
//  TasksDetailView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/31.
//

import SwiftUI

struct TasksDetailView: View {
    var previewModule : Module
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader{ reader in
                AsyncImage(url: URL(string: previewModule.image ?? ""  )) { image in
                    image
                    .resizable()
                    .frame(width: 400, height: 400)
                } placeholder: {
                    ProgressView()
                }
            }
            //MARK: Frame size
            .frame(height: 480)
            VStack(alignment: .leading, spacing: 15) {
                Text("TASK")
            }
     
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TasksDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TasksDetailView(previewModule: .sample)
    }
}
