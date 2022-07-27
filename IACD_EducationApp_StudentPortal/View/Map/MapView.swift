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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        //NavigationView {
       // GeometryReader { geometry in
            ZStack(alignment: .leading){
                MainView(showMenu: self.$showMenu, currentFloor: self.$currentFloor)
                    .frame(width: screen.width, height: screen.size.height)
                if self.showMenu{
                    MapMenuView(currentFloor: self.$currentFloor)
                        .frame(width: screen.size.width/2)
                        .transition(.move(edge: .leading))
                
                
                }
            }
            //}
            //.navigationBarTitle("Side Menu", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: (
                VStack{
                    Button(action : {
                        self.mode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "arrow.left.circle.fill")
                    }
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3.circle.fill")
                            .imageScale(.large)
                    }
                }//
            ))
        }
    }


private struct MainView: View {
    @Binding var showMenu: Bool
    @Binding var currentFloor:Int
    
    
    @State var currentAmount:CGFloat = 0
    @State var lastAmount:CGFloat = 0
    
    @State var currentOffset: CGSize = .zero
    @State var LastOffset: CGSize = .zero
    
    var body: some View {
        
        switch(currentFloor){
        case 0:
            Image("map1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
                .offset(currentOffset)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            currentOffset.width = LastOffset.width + value.translation.width
                            currentOffset.height = LastOffset.height + value.translation.height
                            //currentOffset = value.translation
                        }
                        .onEnded({ value in
                            LastOffset = currentOffset
                        })
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
            Image("map2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
                .offset(currentOffset)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            currentOffset.width = LastOffset.width + value.translation.width
                            currentOffset.height = LastOffset.height + value.translation.height
                            //currentOffset = value.translation
                        }
                        .onEnded({ value in
                            LastOffset = currentOffset
                        })
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
            Image("map3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
                .offset(currentOffset)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            currentOffset.width = LastOffset.width + value.translation.width
                            currentOffset.height = LastOffset.height + value.translation.height
                            //currentOffset = value.translation
                        }
                        .onEnded({ value in
                            LastOffset = currentOffset
                        })
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
            Image("map1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
                .offset(currentOffset)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            currentOffset.width = LastOffset.width + value.translation.width
                            currentOffset.height = LastOffset.height + value.translation.height
                            //currentOffset = value.translation
                        }
                        .onEnded({ value in
                            LastOffset = currentOffset
                        })
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
