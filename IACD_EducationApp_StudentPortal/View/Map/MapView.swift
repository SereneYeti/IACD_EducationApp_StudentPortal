//
//  MapView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/14.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var showMenu = false
    @State private var currentFloor: Int = 0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading){
                    MainView(showMenu: self.$showMenu, currentFloor: self.$currentFloor)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    if self.showMenu{
                        MapMenuView(currentFloor: self.$currentFloor)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
            }
            //.navigationBarTitle("Side Menu", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
        
    }
}

private struct MainView: View {
    @Binding var showMenu: Bool
    @Binding var currentFloor:Int
    
    
    @State var currentAmount:CGFloat = 0
    @State var lastAmount:CGFloat = 0
    
    @State var currentOffset: CGSize = .zero
    
    var body: some View {
        
        switch(currentFloor){
        case 0:
            Image("mapExample1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .offset(currentOffset)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            currentOffset = value.translation
                        }
                )
                .scaleEffect(1 + currentAmount + lastAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            currentAmount = value - 1
                        }
                        .onEnded{ value in
                            lastAmount += currentAmount
                            currentAmount = 0;
                        }
                )
        case 1:
            Image("mapExample2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .offset(currentOffset)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            currentOffset = value.translation
                        }
                )
                .scaleEffect(1 + currentAmount + lastAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            currentAmount = value - 1
                        }
                        .onEnded{ value in
                            lastAmount += currentAmount
                            currentAmount = 0;
                        }
                )
        case 2:
            Image("mapExample3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .offset(currentOffset)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            currentOffset = value.translation
                        }
                )
                .scaleEffect(1 + currentAmount + lastAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            currentAmount = value - 1
                        }
                        .onEnded{ value in
                            lastAmount += currentAmount
                            currentAmount = 0;
                        }
                )
        default:
            Image("mapExample1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .offset(currentOffset)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            currentOffset = value.translation
                        }
                )
                .scaleEffect(1 + currentAmount + lastAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            currentAmount = value - 1
                        }
                        .onEnded{ value in
                            lastAmount += currentAmount
                            currentAmount = 0;
                        }
                )
        }
        
        
        
    }
}

/*
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
 */
