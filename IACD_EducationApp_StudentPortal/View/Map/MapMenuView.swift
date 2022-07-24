//
//  MapMenuView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/19.
//

import SwiftUI

struct MapMenuView: View {
    @State var currentFloor:Int = 0
    let maxFloor = 2
    
    var body: some View {
        VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Profile")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                        .padding(.top, 100)
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Messages")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                        .padding(.top, 30)
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Settings")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                        .padding(.top, 30)
            
            Stepper("Floor: \(currentFloor)", value: $currentFloor, in: 0...maxFloor)
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
                        
                        Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
    }
}

struct MapMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MapMenuView()
    }
}
