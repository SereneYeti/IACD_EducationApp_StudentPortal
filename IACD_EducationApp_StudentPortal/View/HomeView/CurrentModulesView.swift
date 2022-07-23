//
//  CurrentModulesView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/14.
//

import SwiftUI

struct CurrentModulesView: View {
    @State var testVal: Int = 1
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(0..<10) { index in
                    ModuleCardView(moduleID: index)
                }
            }
        }
    }
}

struct ModuleCardView: View{
    @State private var showModuleSheet = false
    @State var module:String = ""
    @State var moduleID:Int = -1; // -1 means no module selected
    
    var body: some View{
        VStack{
            Text("Module Card: \(moduleID)")
                .font(.headline)
            Text("Module Name")
                .font(.subheadline)
                .foregroundColor(.white)
            Button(action: {
                print("ModuleID: \(moduleID)")
                showModuleSheet = true
            }){
                Text("Module Information")
                    .font(.callout)
                    .bold()
                    .foregroundColor(.purple
                    )
            }
        }
        .frame(width: 200, height: 100)
        .background(.black)
        .foregroundColor(.white)
        .cornerRadius(45)
        .sheet(isPresented: $showModuleSheet,
                content: { SelectedModuleView() })
    }
}

struct CurrentModulesView_Previews: PreviewProvider {
    static var previews: some View {
        //HomeView()
        CurrentModulesView()
        ModuleCardView()
        SelectedModuleView()
    }
}
