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
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading){
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    if self.showMenu{
                        MapMenuView()
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
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var viewState = CGSize.zero
    
    var body: some View {
        
        Image("mapExample1")
            .resizable()
            .aspectRatio(contentMode: .fit)
        /*
            .offset(x: viewState.width, y: viewState.height)
            .gesture(DragGesture()
                .onChanged { val in
                    self.viewState = val.translation
                }
            )
            .gesture(MagnificationGesture()
                .onChanged { val in
                    let delta = val / self.lastScale
                    self.lastScale = val
                    if delta > 0.94 { // if statement to minimize jitter
                        let newScale = self.scale * delta
                        self.scale = newScale
                    }
                }
                .onEnded { _ in
                    self.lastScale = 1.0
                }
            )
            .scaleEffect(scale)
            */
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
