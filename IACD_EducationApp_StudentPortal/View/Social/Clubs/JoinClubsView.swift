//
//  JoinClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/28.
//

import SwiftUI

struct JoinClubsView: View {
    @EnvironmentObject var clubsViewModel:ClubsViewModel
    @EnvironmentObject var forumsViewModel:ChatroomsViewModel
    @EnvironmentObject var staffViewModel: CoordinatorViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var clubSet:[Clubs] = []
    
    init(){
        //viewModel.GetAllClubs()
    }
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                ForEach(clubsViewModel.allClubs.indices, id: \.self){ index in
                    if((index+1)<clubsViewModel.allClubs.count){
                        if(index % 2 == 0 && (index+1)%2 == 1){
                            ListCellView(leftClub: clubsViewModel.allClubs[index], rightClub: clubsViewModel.allClubs[index+1]).environmentObject(clubsViewModel).environmentObject(forumsViewModel)
                                .environmentObject(staffViewModel)
                        }
                        
                    }
                    else if((index)<clubsViewModel.allClubs.count)
                    {
                        if(index % 2 == 0){
                            ListCellView(leftClub: clubsViewModel.allClubs[index], rightClub: nil).environmentObject(clubsViewModel).environmentObject(forumsViewModel)
                                .environmentObject(staffViewModel)
                        }
                    }
                    
                }
            }
        }
        .background(
            Image("bg1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                        .offset(y:100)
                )
                .hueRotation(Angle(degrees: -170))
        )
        
        //.background(.ultraThinMaterial)
        //.edgesIgnoringSafeArea(.all)
        .navigationTitle("Available Clubs")        
    }
}

struct ListCellView:View{
    @EnvironmentObject var clubsViewModel:ClubsViewModel
    @EnvironmentObject var forumsViewModel:ChatroomsViewModel
    @EnvironmentObject var staffViewModel: CoordinatorViewModel
    @State var leftClub:Clubs
    @State var rightClub:Clubs?
    
    var body: some View{
        HStack{
            NavigationLink(destination: JoinClubView(isOpen: .constant(true),club: leftClub, coordinator: staffViewModel.GetStaffInfo(staffId: leftClub.Coordinator!)).environmentObject(clubsViewModel).environmentObject(forumsViewModel)){
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
                    //.foregroundColor(.white)
                    //.foregroundColor(Color(red: 32/255, green: 32/255, blue: 32/255))
                    .foregroundColor(.clear)
                    .frame(width: screen.width * 0.5, height: screen.height*0.30, alignment: .center)
                    .padding(1)
                    .overlay {
                        VStack(spacing: 1){
                            Text(leftClub.id!)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .font(.title)
                                .lineLimit(1)
                                .frame(width: screen.width*0.50, alignment: .center)
                                //.padding()
                            AsyncImage(url: URL(string: leftClub.Images![0].URL!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .clipShape(Circle())
                            .shadow(color: .purple, radius: 2, x: 3, y: 3)
                            .padding(.bottom)
                            .padding(.leading)
                            .padding(.trailing)
                        }
                    }
            }
            
            //.background(.green)
            if(rightClub != nil){
                NavigationLink(destination: JoinClubView(isOpen: .constant(true),club: rightClub, coordinator: staffViewModel.GetStaffInfo(staffId: rightClub!.Coordinator!)).environmentObject(clubsViewModel).environmentObject(forumsViewModel)){
                    RoundedRectangle(cornerRadius:  15)
                        .stroke(lineWidth: 2)
                        //.foregroundColor(.white)
                        //.foregroundColor(Color(red: 32/255, green: 32/255, blue: 32/255))
                        .foregroundColor(.clear)
                        .frame(width: screen.width * 0.5, height: screen.height*0.30, alignment: .center)
                        .padding(1)
                        .overlay {
                            VStack(spacing: 1){
                                Text(rightClub!.id!)
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(.blue)
                                    .lineLimit(1)
                                    .padding(.trailing, 1)
                                    .frame(width: screen.width*0.50, alignment: .center)
                                    .minimumScaleFactor(0.2)
                                    //.offset(x: -8, y: 0)
                                    //.multilineTextAlignment(.center)
                                    //.padding()
                                AsyncImage(url: URL(string: rightClub!.Images![0].URL!)) { image in
                                    image.resizable()                                        
                                        
                                } placeholder: {
                                    ProgressView()
                                }
                                .clipShape(Circle())
                                .shadow(color: .purple, radius: 4, x: 3, y: 3)
                                .padding(.bottom)
                                .padding(.leading)
                                .padding(.trailing)
                                
                            }
                        }
                }
                //.background(.indigo)
                
            }
            else
            {
                /* THIS IS THE EMPTY LEFTOVER SHAPE AT THE END OF THE LIST IFTHE LIST IS UNEVEN
                Text("")
                    .frame(width: screen.width * 0.5, height: screen.height*0.15, alignment: .center)
                    .background(.indigo)
                    .clipShape(Circle())
                 */
            }
        }
        //.background( BlurBG(style: .systemUltraThinMaterialDark))
    }
}

struct JoinClubsView_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubsView()
    }
}
