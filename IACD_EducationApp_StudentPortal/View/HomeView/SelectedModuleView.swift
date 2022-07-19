//
//  SelectedModuleView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/18.
//

import SwiftUI

struct SelectedModuleView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .overlay(Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                Text("Dismiss")
                    .font(.headline)
                    .bold()
                    .padding()
            }), alignment: .topLeading)
    }
}

struct SelectedModuleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedModuleView()
    }
}
