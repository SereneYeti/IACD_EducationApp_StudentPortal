    //
    //  ProfileView.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/07/21.
    //

import SwiftUI
import Firebase



struct ProfileView: View {
    @EnvironmentObject var studentManager : StudentModel
    @EnvironmentObject var moduleViewModel : ModuleViewModule
    var body: some View {
        TabView {
            StudentProfileView(moduleViewModel: moduleViewModel)
                .environmentObject(ModuleViewModule())
            StudentCardView()
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ModuleViewModule())
    }
}
struct StudentProfileView: View{
    @ObservedObject var moduleViewModel : ModuleViewModule
    @State var selectedSelection: SelectedSelection = .modules
    var testStu = testData[0]
    @Namespace var animation
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
//                    Image(systemName: "gearshape.fill")
//                        .font(.system(size: 20))
//                    Spacer()
                    
                }
                .padding([.trailing, .bottom , .leading])
                .padding(.bottom)
                
                VStack{
                    Image("Avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    VStack {
                        HStack() {
                            Text(testStu.firstName)
                                .bold()
                            Text(testStu.lastName)
                        }
                        .font(.system(size: 25))
                        Text("Game Design")
                            .font(.subheadline)
                    }
                    .padding(.bottom)
                    
                }
                
                    //MARK: Selectable profile options
                HStack {
                    ForEach(profileOptions){ option in
                        Rectangle()
                            .frame(width: 1, height: 1)
                            .opacity(0.01)
                            .padding(.horizontal, 3)
                        Text(option.text)
                            .padding(12)
                            .foregroundColor(selectedSelection == option.selected ? .white : .primary)
                            //MARK: Capsule Animation
                            .background(
                                ZStack{
                                    if selectedSelection == option.selected{
                                        Capsule()
                                            .fill(.black)
                                            .matchedGeometryEffect(id: "OPTION", in: animation)
                                    }
                                }
                            )
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    selectedSelection = option.selected
                                }
                            }
                    }
                }
                
                Spacer()
                
                    //MARK: Selected Views using a switch for the enums
                switch selectedSelection {
                case .modules:
                    ModulesListView()
                case .tasks:
                    ModuleTasksListView()
                case .dueDates:
                    Text("No Events")
                }
                
            }
        }
    }
}

struct ModulesListView: View{
    @EnvironmentObject var moduleViewModel : ModuleViewModule
    var body: some View{
        ForEach(moduleViewModel.modules) { item in
            NavigationLink{
                ModulesDetailView(previewModule: item, moduleViewModel: moduleViewModel)
            }label: {
                ModulesCardView(previewModule: item)
                    .padding()
            }
           
        }
    }
}

//MARK: Tasks
struct ModuleTasksListView: View{
    @EnvironmentObject var moduleViewModel : ModuleViewModule
    @State var showTasks : Bool = false
    var body: some View{
        ForEach(moduleViewModel.modules){ item in
            ForEach(item.tasks!, id:\.self) { tasks in
                
                NavigationLink{
                    TasksDetailView(previewModule:item , previewTasks: tasks)
                }label:{
                    VStack(spacing: 10) {
                        HStack {
                            VStack {
                                Text(tasks.taskTitle ?? "")
                                    .font(.system(size: 16, weight: .bold))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                            }
                            Spacer()
                        }
                        .padding()
                        HStack{
                            Spacer()
                            Text("Module")
                            Text(item.name ?? "")
                                .bold()

                        }
                        .padding()
                    }
                    .frame(width: screen.width - 50, height: screen.width - 280)
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(hex: item.color ??  "000000"), radius: 1, x: 2, y: 2)
                    .shadow(color: Color(hex: item.color ??  "000000").opacity(0.8), radius: 10, x: 2, y: 2)
                    .tint(.none)
                }
                
            }
        }
        .padding(15)
    }
}

    //MARK: tab Tasks
    struct ModuleTasksTabView: View{
        @EnvironmentObject var moduleViewModel : ModuleViewModule
        @State var showTasks : Bool = false
        var body: some View{
            ForEach(moduleViewModel.modules){ item in
                ForEach(item.tasks!, id:\.self) { tasks in
                    TabView{
                    NavigationLink{
                        TasksDetailView(previewModule:item , previewTasks: tasks)
                    }label:{
                        
                        VStack(spacing: 10) {
                            HStack {
                                VStack {
                                    Text(tasks.taskTitle ?? "")
                                        .font(.system(size: 16, weight: .bold))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(3)
                                }
                                Spacer()
                            }
                            .padding()
                            HStack{
                                Spacer()
                                Text("Module")
                                Text(item.name ?? "")
                                    .bold()

                            }
                            .padding()
                        }
                        .frame(width: screen.width - 50, height: screen.width - 280)
                        .background(.background)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color(hex: item.color ??  "000000"), radius: 1, x: 2, y: 2)
                        .shadow(color: Color(hex: item.color ??  "000000").opacity(0.8), radius: 10, x: 2, y: 2)
                        .tint(.none)
                    }
                    
                }
                    .frame(width: screen.width - 50, height: screen.width - 280)
                }
            }
            .padding(15)
        }
    }


struct ProfileSelections : Identifiable{
    var id = UUID()
    var text: String
    var selected: SelectedSelection
}

enum SelectedSelection{
    case modules
    case tasks
    case dueDates
}


var profileOptions = [
    ProfileSelections(text: "Modules", selected: .modules),
    ProfileSelections(text: "Tasks", selected: .tasks),
    ProfileSelections(text: "Events", selected: .dueDates)
]
