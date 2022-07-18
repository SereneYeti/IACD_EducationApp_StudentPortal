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
    case Modules
    case Clubs
    case Account    
}
//NavigationLink("Go to Other Page", destination: //ContenvtViewB()).tabItem
struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var selectedItem:tabs = .Home
    @State var showWelcomeScreen: Bool = false
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedItem) {
                HomeView().tabItem
                {
                    Image(systemName: "house.fill")
                    Text("Home").bold()
                }.tag(tabs.Home)
                CalendarView().tabItem
                {
                    Image(systemName: "calendar.circle.fill")
                    Text("Calendar").bold()
                }.tag(tabs.Calendar)
                AccountWorkoutView().tabItem{
                    Image(systemName: "person.crop.circle.fill")
                    Text("Account").bold()
                }.tag(tabs.Account)
            }.onAppear(){
                UITabBar.appearance().backgroundColor = .lightGray
                print("View Model Sign In: \(viewModel.firstTimeSignIn)")
                showWelcomeScreen = viewModel.firstTimeSignIn
            }.accentColor(.blue)
                .sheet(isPresented: $showWelcomeScreen, content: {
                CalendarView()
            })
        }
    }
}

struct AccountWorkoutView: View {
    var body: some View{
        Text("This is the account view.")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
        HomeView().environmentObject(AppViewModel())
        CalendarView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        AccountWorkoutView()
        
    }
}

