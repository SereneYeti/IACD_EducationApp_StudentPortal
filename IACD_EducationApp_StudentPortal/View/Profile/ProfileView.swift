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
    
    var body: some View {
        TabView {
            StudentProfileView()
                .environmentObject(StudentModel())
            StudentCardView()
            CalendarHome()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        
    }
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(StudentModel())
    }
}
struct StudentProfileView: View{
    @EnvironmentObject var stu : StudentModel
    @State var selectedSelection: SelectedSelection = .classes
    var testStu = testData[0]
    @Namespace var animation
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 25))
                    Spacer()
                    
                }
                .padding([.trailing, .bottom , .leading])
                .padding(.bottom)
                
                VStack{
                    Image("Avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    
                        //                .overlay {
                        //                    Image(systemName: "2.circle.fill")
                        //                        .font(.system(size: 25))
                        //                        .foregroundColor(.primary)
                        //                }
                    
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
                case .classes:
                    ClassesCardListView()
                        .padding()
                        .padding(.top)
                case .dueDates:
                    Text("No Events")
                }
                
            }
        }
    }
}

struct ModulesListView: View{
    var body: some View{
        ForEach(0 ..< 3) { item in
            ModulesCardView(previewModule: testModule[0])
                .padding()
        }
    }
}


struct ProfileSelections : Identifiable{
    var id = UUID()
    var text: String
    var selected: SelectedSelection
}

enum SelectedSelection{
    case modules
    case classes
    case dueDates
}


var profileOptions = [
    ProfileSelections(text: "Modules", selected: .modules),
    ProfileSelections(text: "Classes", selected: .classes),
    ProfileSelections(text: "Events", selected: .dueDates)
]
