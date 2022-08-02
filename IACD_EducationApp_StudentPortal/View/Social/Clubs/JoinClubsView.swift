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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var clubSet:[Clubs] = []
    
    init(){
        //viewModel.GetAllClubs()
    }
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                ForEach(clubsViewModel.allClubs.indices){ index in
                    if((index+1)<clubsViewModel.allClubs.count){
                        if(index % 2 == 0 && (index+1)%2 == 1){
                            ListCellView(leftClub: clubsViewModel.allClubs[index], rightClub: clubsViewModel.allClubs[index+1]).environmentObject(clubsViewModel).environmentObject(forumsViewModel)
                        }
                        
                    }
                    else if((index)<clubsViewModel.allClubs.count)
                    {
                        if(index % 2 == 0){
                            ListCellView(leftClub: clubsViewModel.allClubs[index], rightClub: nil).environmentObject(clubsViewModel).environmentObject(forumsViewModel)
                        }
                    }
                    
                }
            }
            
        }
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        //.background(.ultraThinMaterial)
        //.edgesIgnoringSafeArea(.all)
        .navigationTitle("Available Clubs")        
    }
}

struct ListCellView:View{
    @EnvironmentObject var clubsViewModel:ClubsViewModel
    @EnvironmentObject var forumsViewModel:ChatroomsViewModel
    @State var leftClub:Clubs
    @State var rightClub:Clubs?
    
    var body: some View{
        HStack{
            NavigationLink(destination: JoinClubView(isOpen: .constant(true),club: leftClub).environmentObject(clubsViewModel).environmentObject(forumsViewModel)){
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
                    //.foregroundColor(.white)
                    .foregroundColor(Color(red: 32/255, green: 32/255, blue: 32/255))
                    .frame(width: screen.width * 0.5, height: screen.height*0.30, alignment: .center)
                    .padding(1)
                    .overlay {
                        VStack(spacing: 1){
                            Text(leftClub.id!)
                                .fontWeight(.bold)
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
                NavigationLink(destination: JoinClubView(isOpen: .constant(true),club: rightClub).environmentObject(clubsViewModel).environmentObject(forumsViewModel)){
                    RoundedRectangle(cornerRadius:  15)
                        .stroke(lineWidth: 2)
                        //.foregroundColor(.white)
                        .foregroundColor(Color(red: 32/255, green: 32/255, blue: 32/255))
                        .frame(width: screen.width * 0.5, height: screen.height*0.30, alignment: .center)
                        .padding(1)
                        .overlay {
                            VStack(spacing: 1){
                                Text(rightClub!.id!)
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .lineLimit(1)
                                    .padding(.trailing, 1)
                                    .frame(width: screen.width*0.50, alignment: .center)
                                    .minimumScaleFactor(0.4)
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
    }
}

struct JoinClubsView_Previews: PreviewProvider {
    static var previews: some View {
        JoinClubsView()
    }
}
