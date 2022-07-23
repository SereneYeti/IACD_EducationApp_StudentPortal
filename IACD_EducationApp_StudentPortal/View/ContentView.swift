    //
    //  ContentView.swift
    //  JvieyraSwiftUITestBed
    //
    //  Created by IACD-011 on 2022/06/01.
    //
import SwiftUI

public enum tabs : Hashable{
    case Home
    case Calendar
    case Map
    case Modules
    case Clubs
    case Account
}
    //NavigationLink("Go to Other Page", destination: //ContenvtViewB()).tabItem
struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var selectedItem:tabs = .Home   
    
    var body: some View {
        
        TabView(selection: $selectedItem) {
            HomeView().tabItem
            {
                Image(systemName: "house.fill")
                Text("Home").bold()
            }.tag(tabs.Home)
            CalendarHome()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem
            {
                Image(systemName: "calendar.circle.fill")
                Text("Calendar").bold()
            }.tag(tabs.Calendar)
            MapView().tabItem{
                Image(systemName: "map.circle")
                Text("Map").bold()
            }.tag(tabs.Map)
            AccountView().tabItem{
                Image(systemName: "person.crop.circle.fill")
                Text("Account").bold()
            }.tag(tabs.Account)
        }.onAppear(){
            UITabBar.appearance().backgroundColor = .lightGray
            
        }.accentColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
//        HomeView().environmentObject(AppViewModel())
//        CalendarView()
//            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

