//
//  ClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/26.
//

import SwiftUI

//TODO: LIST
//      - Make club view look nice
//TODO: ENDLIST
struct ClubView: View {
    @State var newTask = false
    @State var club:Clubs
    @State var coordinator:Coordinator
    @EnvironmentObject var taskModel: TaskViewModel
    @EnvironmentObject var clubViewModel:ClubsViewModel
    @EnvironmentObject var staffViewModel: CoordinatorViewModel
    let persistenceController = PersistenceController.shared
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack{
                HStack{
                    Text("Club Coordinator: \(coordinator.name!)")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .alignmentGuide(HorizontalAlignment.leading) { _ in
                            0
                        }
                    
                    AsyncImage(url: URL(string: coordinator.image!)) { image in
                        image.resizable()
                        
                            
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: screen.width*0.10, height: screen.height*0.05)
                    .cornerRadius(20)
                    .clipped()
                    //.border(.indigo, width: 4)
                    //.clipShape(Circle())
                    .alignmentGuide(HorizontalAlignment.trailing) { _ in
                        0
                    }
                    
                }
                .alignmentGuide(.leading) { _ in 0 }
                .frame(width: screen.width, alignment: .topLeading)
                
                TabView{
                    ForEach(club.Images!, id:\.self){ image in
                        ImgView(URL:image.URL!,credit: image.credit!)
                            
                    }
                }
                .frame(width: screen.width*1.0, height: screen.height*0.42)
                .tabViewStyle(.page(indexDisplayMode: .always))
                //.cornerRadius(15)
                
                Divider()
                
                Text("Club Description: \(club.ClubDescription!)")
                    .font(.body)
                    .fontWeight(.regular)
                    .padding()
                    .alignmentGuide(HorizontalAlignment.leading) { _ in
                        0
                    }
                
                
                VStack{
                    Text("Equipment Needed:")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(width: screen.width , alignment: .center)
                    
                    ForEach(club.RequiredEquipment!.indices) { index in
                        Text("  - \(club.RequiredEquipment![index])")
                            .font(.body)
                            .fontWeight(.regular)
                            .frame(width: screen.width,alignment: .center)
                            .padding(2)
                            
                    }
                }
                .padding(.bottom)
                
                
                HStack {
                    
                    Text("Create Club Meetup")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                    
                    UpcomingClubsTaskView(currentClub: club)
                    
                }
                .padding(.top)
                .frame(width: screen.width*0.75, alignment: .center)
                .background(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.indigo, lineWidth: 2)
                        .opacity(0.7)
                        .shadow(color: .blue, radius: 3, x: 3, y: 3)
                )
                

                Spacer()
                
                VStack{
                    Text("Useful Information ")
                        .font(.headline)
                        .underline()
                        .frame(width: screen.width,alignment: .center)
                        .shadow(color: .gray, radius: 5, x: 10, y: 10)
                        .padding()
                   
                    ForEach(club.Helpful_Information!.indices){index in
                        VStack(spacing: 2.5){
                            Text("\(club.Helpful_Information![index].name)")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.gray)
                                .frame(width: screen.width*0.94,alignment: .center)
                                .offset(CGSize(width: 0, height: -2))
                                .padding(.top)
                            Text("  - Description : \(club.Helpful_Information![index].infoDescription)")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .frame(width: screen.width*0.92,alignment: .center)
                                .padding(2)
                            Link("Open website", destination: URL(string: club.Helpful_Information![index].link) ?? URL(string: "www.google.com")!)
                                .padding(2)
                                .padding(.bottom)
                                
                        }
                        .frame(width: screen.width*0.95)
                        .background(.bar)
                        .cornerRadius(20)
                        .shadow(color: .purple, radius: 3, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.indigo, lineWidth: 2)
                                .opacity(0.7)
                        )
                    }
                }
            }
          
        }
        .navigationTitle(club.id!)
        //.ignoresSafeArea(.all)
    }
    
}
/*
struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        //ClubView(club: Clubs(id: "", Coordinator: 1195143, ClubDescription: "", Helpful_Information: [], Meetups: [], RequiredEquipment: [], forumID: -1, members: []), coordinator: )
    }
}*/
