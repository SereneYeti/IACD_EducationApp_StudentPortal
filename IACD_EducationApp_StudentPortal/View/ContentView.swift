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
    case Forums
    case Modules
    case Clubs
    case Account
}
    //NavigationLink("Go to Other Page", destination: //ContenvtViewB()).tabItem
struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var selectedItem:tabs = .Home    
    
    @ObservedObject var forumsViewModel =  AppViewModel()
    
    init() {
        forumsViewModel.listen()
    }
    
    var body: some View {
        
        TabView(selection: $selectedItem) {
            HomeView()
                .tabItem
            {
                Image(systemName: "house.fill")
                Text("Home").bold()
            }.tag(tabs.Home)
            SocialView()
                .tabItem{
                Image(systemName: "newspaper.circle.fill")
                Text("Social").bold()
            }.tag(tabs.Forums)
            ProfileView().environmentObject(StudentModel())
                .tabItem{
                Image(systemName: "person.crop.circle.fill")
                Text("Account").bold()
            }.tag(tabs.Account)
        }
        .onAppear()
        {
            UITabBar.appearance().backgroundColor = .lightGray
        }
        .accentColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
        //ChatroomListView()
//        HomeView().environmentObject(AppViewModel())
//        CalendarView()
//            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

