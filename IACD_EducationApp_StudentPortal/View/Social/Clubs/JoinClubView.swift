//
//  JoinClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/28.
//

import SwiftUI

struct JoinClubView: View {
    @Binding var isOpen:Bool
    @EnvironmentObject var viewModel:ClubsViewModel
    @EnvironmentObject var forumsViewModel:ChatroomsViewModel
    @State var club:Clubs?
    @State var coordinator:Coordinator
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var count = 0
    
    
    var body: some View {
        ScrollView(.vertical){
            VStack {
                
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
                    ForEach(club!.Images!, id:\.self){ image in
                        ImgView(URL:image.URL!,credit: image.credit!)
                            
                    }
                }
                .frame(width: screen.width*1.0, height: screen.height*0.42)
                .tabViewStyle(.page(indexDisplayMode: .always))
                
                Group{
                    Divider()
                    
                    Text("Club Description: \(club!.ClubDescription!)")
                        .font(.body)
                        .fontWeight(.regular)
                        .padding()
                        .alignmentGuide(HorizontalAlignment.leading) { _ in
                            0
                        }
                }
                
                
                Group{
                    Text("Equipment Needed:")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .alignmentGuide(HorizontalAlignment.leading) { _ in
                            0
                        }
                    
                    ForEach(club!.RequiredEquipment!.indices) { index in
                        Text("  - \(club!.RequiredEquipment![index])")
                            .font(.body)
                            .fontWeight(.regular)
                            .frame(width: screen.width,alignment: .leading)
                            .padding(2)
                        
                    }
                }
                
                Spacer()
                
                VStack{
                    Text("Useful Information ")
                        .font(.headline)
                        .bold()
                        .frame(width: screen.width,alignment: .center)
                        .padding()
                    ForEach(club!.Helpful_Information!.indices){index in
                        VStack(spacing: 2.5){
                            Text("\(club!.Helpful_Information![index].name)")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.gray)
                                .frame(width: screen.width,alignment: .center)
                                .offset(CGSize(width: 0, height: -2))
                                .padding(.top)
                            Text("  - Description : \(club!.Helpful_Information![index].infoDescription)")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .frame(width: screen.width,alignment: .center)
                                .padding(2)
                            Link("Open website", destination: URL(string: club!.Helpful_Information![index].link) ?? URL(string: "www.google.com")!)
                                .padding(2)
                            
                        }
                        .frame(width: screen.width)
                        .border(.indigo, width: 2)
                    }
                }
            }
            .navigationTitle(club!.id!)
            if(!viewModel.InClub(ClubID: club!.id!)){
                Button {
                    viewModel.joinClub(clubID: club!.id!)
                    print("joining with code \(club!.forumID!)")
                    forumsViewModel.joinChatroom(code: club!.forumID!, handler: {
                        self.isOpen = false
                    })
                    //JoinClubsView().mode.wrappedValue.dismiss()
                    //self.mode.wrappedValue.dismiss()
                    print("Joined club: \(club!.id!)")
                    
                } label: {
                    Text("Join Club")
                        .padding(2)
                        .background(.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    
                }
                .padding()
                
            }
        }
    }
}



struct JoinClubView_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubView(isOpen: .constant(true),club: nil, coordinator: Coordinator(id: "", name: "", ContactNumber: -1, staffID: -1, image: ""))
    }
}