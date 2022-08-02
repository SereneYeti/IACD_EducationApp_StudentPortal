//
//  SocialView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/27.
//

import SwiftUI

struct SocialView: View {
    @ObservedObject var forumsViewModel =  ChatroomsViewModel()
    @ObservedObject var clubsViewModel:ClubsViewModel = ClubsViewModel()
    @EnvironmentObject var taskModel:TaskViewModel
    @EnvironmentObject var staffViewModel:CoordinatorViewModel
    
    fileprivate func MakeNewClub(CoordinatorID:Int) {
        let hi = Helpful_Information(name: "Shootfactory", link: "https://www.shootfactory.co.uk/improve-your-mobile-phone-photography-with-these-tips/", infoDescription: "Improve your mobile phone photography with this simple guide! use this information to help you start your journey")
        var hiArr:[Helpful_Information] = []
        hiArr.append(hi)
        let forumID = forumsViewModel.createJoinCode()
        let RequiredEquipment = ["Smartphone","Creativity","(Optional) - Camera"]
        let Images = [Images(URL: "https://www.shootfactory.co.uk/wp-content/uploads/2018/03/Mobile-Phone-Photography.png", credit: "https://www.shootfactory.co.uk/improve-your-mobile-phone-photography-with-these-tips/"), Images(URL: "", credit: "https://www.pexels.com/photo/selective-focus-photography-of-woman-holding-dslr-camera-1264210/")]
        var isOpen = false
        forumsViewModel.createClubChatroom(title: "Photography",  handler: {
           isOpen = false
        }, joinCode: forumID)
        clubsViewModel.AddNewClubDocument(id: "Photography", Coordinator:CoordinatorID, ClubDescription: "If you enjoy taking photo's this is the club for you! We regularly take photos around campus and the city and have excursions every weekend! All you need is a smartphone to get started so join us to enhance your cretivity today!", Helpful_Information: hiArr, Meetups: [], RequiredEquipment: RequiredEquipment, Images: Images, forumID: forumID, members: [])
    }
    
    init(){

        forumsViewModel.fetchData()
        
        //MakeNewClub()
        
        clubsViewModel.GetUserClubs()
    }
    
    var body: some View {
        VStack(spacing: 1){
            //Text("My Clubs")
            //  .font(.title)
            //.bold()
            //.frame(width: screen.width, height: screen.height*0.05, alignment: .center)
            
            ClubCardsView().environmentObject(clubsViewModel).environmentObject(forumsViewModel).environmentObject(taskModel)
                .environmentObject(staffViewModel)
                .frame(width: screen.width, height: screen.height*0.28)
                //.background(.background)
                .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                //.ignoresSafeArea(.all, edges: .top)
                .padding()
            //.navigationTitle("My Clubs")
            
            Divider().background(Color(red: 244/255, green: 243/255, blue: 248/255))
                .frame(height:2)
                .overlay(.indigo)
                .opacity(0.7)
            
            ChatroomListView().environmentObject(forumsViewModel)
                .padding()
                .frame(width: screen.width)
                //.background(.background)
                .background(Color(red: 244/255, green: 243/255, blue: 248/255))
                .ignoresSafeArea(.all, edges: .bottom)
                
        }
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .navigationBarHidden(true)
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
