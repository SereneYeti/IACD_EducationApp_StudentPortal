    //
    //  ModulesDetailView.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/07/31.
    //

import SwiftUI

struct ModulesDetailView: View {
    var previewModule : Module
    @ObservedObject var moduleViewModel : ModuleViewModule
    var body: some View {
        ScrollView( showsIndicators: false){
            VStack {
                VStack {
                    AsyncImage(url: URL(string: previewModule.image ?? "" )) { image in
                        image
                            .resizable()
                            .frame(width: 400, height: 400)
                            .shadow(color: Color(hex: previewModule.color ?? "" ), radius: 2, x: 2, y: 2)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(previewModule.name ?? "")
                        .font(.system(size: 35, weight: .bold))
                        .hLeading()
                        .padding(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                }
                Spacer()
                    .frame(height: 20)
                    //MARK: Lecturer
                VStack {
                    Image("Avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(.white, lineWidth: 2)
                        )
                        .hLeading()
                        .background(
                            HStack {
                                Text("Lecturer :")
                                Text(previewModule.lecturer ?? "")
                                    .bold()
                            }
                                .hLeading()
                                .background(
                                    Rectangle()
                                        .frame(width: 250, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 60, style: .continuous))
                                        .foregroundColor(Color(hex: previewModule.color ?? ""))
                                        .hLeading()
                                        .offset(x: -10)
                                    
                                )
                                .offset(x: 20,y:30)
                        )
                     
                       
                }
                .padding(.leading)
                
                Spacer()
                    .frame(height: 60)
                    //MARK: Content
                Text("Content")
                    .font(.system(size: 30, weight: .light))
                    .hLeading()
                    .padding()
                
                    //MARK: Content Blocks
                
                
                GeometryReader { geometry  in
                    ContentBlockView(moduleViewModel: moduleViewModel)
                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 50 ) / -20), axis: (x: 0, y: 10, z: 0))
                }
                .frame(width: screen.width, height: 200)
                
                
                Spacer()
                    .frame(height: 60)
                
                Text("Tasks")
                    .font(.system(size: 30, weight: .light))
                    .hLeading()
                    .padding()
                    //MARK: Tasks
                
            
            }
        }
    }
}

struct ModulesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ModulesDetailView(previewModule: .sample, moduleViewModel: ModuleViewModule())
    }
}
