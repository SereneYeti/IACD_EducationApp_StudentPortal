//
//  ClubCardsView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/27.
//

import SwiftUI
import Foundation


struct ClubCardsView: View {
    @State var clubID:String?
    @State var clubDescription:String?
    @EnvironmentObject var clubsViewModel:ClubsViewModel
    @EnvironmentObject var forumsViewModel:ChatroomsViewModel
    @EnvironmentObject var taskModel: TaskViewModel
    @EnvironmentObject var staffViewModel: CoordinatorViewModel
    @State var displayed:Bool = false
    
    
    init(){
        //code
        
    }
    
    var body: some View {
        VStack{
            Text("My Clubs")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: screen.width, alignment: .center)
            ScrollView(.horizontal) {
                HStack(alignment: .center){
                    ClubCardView(club: nil).environmentObject(clubsViewModel).environmentObject(forumsViewModel).environmentObject(taskModel).environmentObject(staffViewModel)
                        .frame(width: screen.width*0.5, height: screen.height * 0.25, alignment: .center)
                    //.padding()
                    ForEach($clubsViewModel.userClubs){ i in
                        
                        ClubCardView(club: i.wrappedValue, coordinator: staffViewModel.GetStaffInfo(staffId: i.wrappedValue.Coordinator!)).environmentObject(clubsViewModel).environmentObject(forumsViewModel).environmentObject(taskModel)
                            .frame(width: screen.width*0.5, height: screen.height * 0.25, alignment: .center)
                        
                    }
                }
            }
        }
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct ClubCardView:View{
    @State var club:Clubs?
    @State var coordinator:Coordinator?
    var cornerRadius:CGFloat = 20
    @EnvironmentObject var clubsViewModel:ClubsViewModel
    @EnvironmentObject var forumsViewModel:ChatroomsViewModel
    @EnvironmentObject var taskModel: TaskViewModel
    @EnvironmentObject var staffViewModel: CoordinatorViewModel
    
    
    var body: some View{
        VStack{
            if(club != nil){
                NavigationLink(destination: ClubView(club: self.club!,coordinator: staffViewModel.GetStaffInfo(staffId: club!.Coordinator!)).environmentObject(clubsViewModel).environmentObject(taskModel).environmentObject(staffViewModel)){
                    VStack{
                        AsyncImage(url: URL(string: club!.Images![0].URL!)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: screen.width*0.42, height: screen.height*0.15)
                        .cornerRadius(self.cornerRadius-5)
                        Text("\(club!.id!)")
                            .padding(.top, 5)
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        Text("Coordinator: \(coordinator!.name!)")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .fontWeight(Font.Weight.light)
                            .multilineTextAlignment(.center)
                            .padding(.bottom,10)
                        
                    }
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(self.cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: self.cornerRadius)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.indigo)
                            .opacity(1)
                            .shadow(color: .purple, radius: 2, x: 3, y: 3)
                    )
                }
            }
            else
            {
                NavigationLink(destination: JoinClubsView().environmentObject(clubsViewModel).environmentObject(forumsViewModel).environmentObject(staffViewModel)){
                    VStack{
                        Image(systemName:"plus")
                            .font(.largeTitle)
                            .padding(3)
                        Text("Join a Club")
                            .font(.headline)
                            .padding(6)
                    }
                    .foregroundColor(.white)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(self.cornerRadius-5)
                    .overlay(
                        RoundedRectangle(cornerRadius: self.cornerRadius-5)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.indigo)
                            .opacity(1)
                            .shadow(color: .purple, radius: 2, x: 3, y: 3)
                                       
                    )
                }
            }
        }
    }
}

/*
 struct ClubCardsView_Previews: PreviewProvider {
 static var previews: some View {
 ClubCardsView().environmentObject(ClubsViewModel())
 //ClubCardView()
 }
 }
 */
