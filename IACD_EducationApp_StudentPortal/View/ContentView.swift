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
    @State var verified:Bool = false
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @ObservedObject var forumsViewModel =  AppViewModel()
    @ObservedObject var staffViewModel:CoordinatorViewModel = CoordinatorViewModel()
    
    init() {
        print("listening")
        forumsViewModel.listen()
    }
    
    var body: some View {
        
        TabView(selection: $selectedItem) {
            HomeViewMockUp(verified: $verified).environmentObject(viewModel).environmentObject(taskModel).tabItem
            {
                Image(systemName: "house.fill")
                Text("Home").bold()
                
            }.tag(tabs.Home)
            if(self.verified){
                SocialView().environmentObject(taskModel).environmentObject(staffViewModel).tabItem{
                    Image(systemName: "newspaper.circle.fill")
                    Text("Social").bold()
                }.tag(tabs.Forums)
                ProfileView()
                    .environmentObject(ModuleViewModule())
                    //.environmentObject(viewModel)
                    .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile").bold()
                }.tag(tabs.Account)
            }
        }.onAppear(){
            UITabBar.appearance().backgroundColor = .lightGray
            
        }.accentColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
        ChatroomListView()
    }
}

