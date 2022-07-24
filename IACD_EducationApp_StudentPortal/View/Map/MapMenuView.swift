//
//  MapMenuView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/19.
//

import SwiftUI


struct MapMenuView: View {
    
    let floor0:[String] = ["Academic Operations & RN Office", "Eat Fresh Canteen", "Finance", "Frontline (Reception)", "Guggenheim Auditorium", "High Voltage", "Mass Energy Room", "No.5", "Paper Magic", "Template"]
    let floor1:[String] = ["Braun", "Disruption", "Ijuse", "Library", "Memphis", "No 670", "Purple Cow", "Rhythm 10", "Rolling Stone", "Sound Stone", "Star Wars", "Space X", "Strangeland", "Tiny Studio"] //NOTE - TODO: DIGITAL STUDIOS LIST?
    let floor2:[String] = ["Bibi Aisha", "Fifteen Minutes", "Ideal City", "Hyperloop", "Obey Giant", "Pulp Fiction", "Vertigo", "Wellness Navigator"]
    
    @State var currentFloor:Int = 0
    let maxFloor = 2
    
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading) {
                Spacer()
                /* EXAMPLE FROM TUTORIAL
                 HStack {
                 Image(systemName: "person")
                 .foregroundColor(.gray)
                 .imageScale(.large)
                 Text("Profile")
                 .foregroundColor(.gray)
                 .font(.headline)
                 }
                 .padding(.top, 100)
                 */
                
                switch(currentFloor){
                case 0:
                    ForEach(floor0, id: \.self){ building in
                        Text(building)
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding()
                        
                    }
                case 1:
                    ForEach(floor1, id: \.self){ building in
                        Text(building)
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding()
                        
                    }
                case 2:
                    ForEach(floor2, id: \.self){ building in
                        Text(building)
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding()
                        
                    }
                default:
                    Text("Default")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .padding()
                    
                }
                
                HStack{
                    Text("Floor: \(currentFloor)")
                        .font(.headline)
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(.gray)
                        .padding()
                    Stepper("", value: $currentFloor, in: 0...maxFloor)
                    .foregroundColor(.gray)
                    .padding()
                    
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MapMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MapMenuView()
    }
}
