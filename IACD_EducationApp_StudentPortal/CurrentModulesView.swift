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
                ForEach(0..<10) {
                    
                    Text("Row \($0)")
                    
                }
            }
        }
    }
}

struct ModuleCardView: View{
    @State var module:String = ""
    
    var body: some View{
        Text("Hello, World!")
    }
}

struct CurrentModulesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentModulesView()
        ModuleCardView()
    }
}
