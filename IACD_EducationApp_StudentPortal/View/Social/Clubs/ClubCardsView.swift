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
    @ObservedObject var viewModel =  ClubsViewModel()
    @State var displayed:Bool = false
    
    
    init(){
        //code
        viewModel.GetUserClubs()
    }
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack(alignment: .center){
                ClubCardView(club: nil).environmentObject(viewModel)
                    .frame(width: screen.width*0.5, height: screen.height * 0.25, alignment: .center)
                //.padding()
                ForEach($viewModel.userClubs){ i in
                    
                    ClubCardView(club: i.wrappedValue).environmentObject(viewModel)
                        .frame(width: screen.width*0.5, height: screen.height * 0.25, alignment: .center)
                    
                }
                .navigationTitle("My Clubs")
            }            
            
            
        }
    }
    
    
}

struct ClubCardView:View{
    @State var club:Clubs?
    var cornerRadius:CGFloat = 20
    @EnvironmentObject var viewModel:ClubsViewModel
    
    var body: some View{
        VStack{
            if(club != nil){
                //Image(systemName:club!.SF_Symbol!)
                //  .padding(1)
                NavigationLink(destination: ClubView(club: self.club!).environmentObject(viewModel)){
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
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                        Text("Coordinator: \(club!.Coordinator!)")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                            .fontWeight(Font.Weight.light)
                            .multilineTextAlignment(.center)
                            .padding(.bottom,10)
                        
                    }
                    .padding(8)
                    .background(.bar)
                    .cornerRadius(self.cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: self.cornerRadius)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                    )
                    
                }
                
            }
            else
            {
                NavigationLink(destination: JoinClubsView().environmentObject(viewModel)){
                    VStack{
                        Image(systemName:"plus")
                            .font(.largeTitle)
                            .padding(3)
                        Text("Join a Club")
                            .font(.headline)
                            .padding(6)
                    }
                    //.padding(8)
                    .background(.bar)
                    .cornerRadius(self.cornerRadius-5)
                    .overlay(
                        RoundedRectangle(cornerRadius: self.cornerRadius-5)
                            .stroke(lineWidth: 2)
                    )
                }
            }
        }
    }
}

struct ClubCardsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubCardsView().environmentObject(ClubsViewModel())
        //ClubCardView()
    }
}
