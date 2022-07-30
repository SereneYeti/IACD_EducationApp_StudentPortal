//
//  JoinClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/28.
//

import SwiftUI

struct JoinClubsView: View {
    @EnvironmentObject var viewModel:ClubsViewModel
    var clubSet:[Clubs] = []
    
    init(){
        //viewModel.GetAllClubs()
    }
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                ForEach(0 ..< viewModel.allClubs.count){ index in
                    if((index+1)<viewModel.allClubs.count){
                        if(index % 2 == 0 && (index+1)%2 == 1){
                            ListCellView(leftClub: viewModel.allClubs[index], rightClub: viewModel.allClubs[index+1]).environmentObject(viewModel)
                        }
                        
                    }
                    else if((index)<viewModel.allClubs.count)
                    {
                        if(index % 2 == 0){
                            ListCellView(leftClub: viewModel.allClubs[index], rightClub: nil).environmentObject(viewModel)
                        }
                    }
                    
                }
            }
            
        }
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        //.edgesIgnoringSafeArea(.all)
        .navigationTitle("Available Clubs")        
    }
}

struct ListCellView:View{
    @EnvironmentObject var viewModel:ClubsViewModel
    @State var leftClub:Clubs
    @State var rightClub:Clubs?
    
    var body: some View{
        HStack{
            NavigationLink(destination: JoinClubView(club: leftClub).environmentObject(viewModel)){
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
                    //.foregroundColor(.white)
                    .foregroundColor(Color(red: 32/255, green: 32/255, blue: 32/255))
                    .padding(1.0)
                    .frame(width: screen.width * 0.5, height: screen.height*0.30, alignment: .center)
                    .overlay {
                        VStack{
                            Text(leftClub.id!)
                                .fontWeight(.bold)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                //.padding()
                            AsyncImage(url: URL(string: leftClub.Images![0].URL!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .clipShape(Circle())
                            .padding()
                        }
                    }
                    
            }
            
            
            //.background(.green)
            if(rightClub != nil){
                NavigationLink(destination: JoinClubView(club: rightClub)){
                    RoundedRectangle(cornerRadius:  15)
                        .stroke(lineWidth: 2)
                        //.foregroundColor(.white)
                        .foregroundColor(Color(red: 32/255, green: 32/255, blue: 32/255))
                        .frame(width: screen.width * 0.5, height: screen.height*0.30, alignment: .center)
                        .overlay {
                            VStack{
                                Text(rightClub!.id!)
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                    //.padding()
                                AsyncImage(url: URL(string: rightClub!.Images![0].URL!)) { image in
                                    image.resizable() 
                                } placeholder: {
                                    ProgressView()
                                }
                                .clipShape(Circle())
                                .padding()
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
