//
//  ClubView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/26.
//

import SwiftUI


//TODO: LIST
//      - ADD WAY FOR USER TO JOIN CLUBS
//      - Make club view look nice
//TODO: ENDLIST
struct ClubView: View {
    @State var club:Clubs
    
    var body: some View {
        ScrollView(.vertical) {
            VStack{
                HStack{
                    Text("Club Coordinator: \(club.Coordinator!)")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .alignmentGuide(HorizontalAlignment.leading) { _ in
                            0
                        }
                    
                    AsyncImage(url: URL(string: "https://a57.foxnews.com/a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2018/09/640/320/1862/1048/georgeclooney640.jpg?ve=1&tl=1?ve=1&tl=1")) { image in
                            image.resizable()
                            .aspectRatio(1, contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: screen.width*0.10, height: screen.height*0.05)
                    .clipShape(Circle())
                    .alignmentGuide(HorizontalAlignment.trailing) { _ in
                        0
                    }
                    
                }
                .alignmentGuide(.leading) { _ in 0 }
                .frame(width: screen.width, alignment: .topLeading)
                
                AsyncImage(url: URL(string: club.Images![0].URL!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: screen.width*1.0, height: screen.height*0.42)
                .alignmentGuide(HorizontalAlignment.leading) { _ in
                    0
                }
                Text("Image taken by \(club.Images![0].credit!)")
                    .font(.caption)
                    .fontWeight(.light)
                    .padding()
                    .alignmentGuide(HorizontalAlignment.leading) { _ in
                        0
                    }
                //.cornerRadius(15)
                
                Divider()
                
                Text("Club Description: \(club.ClubDescription!)")
                    .font(.body)
                    .fontWeight(.regular)
                    .padding()
                    .alignmentGuide(HorizontalAlignment.leading) { _ in
                        0
                    }
                
                
                Text("Equipment Needed:")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                    .alignmentGuide(HorizontalAlignment.leading) { _ in
                        0
                    }
                ForEach(club.RequiredEquipment!.indices) { index in
                    Text("  - \(club.RequiredEquipment![index])")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(2)
                        .alignmentGuide(HorizontalAlignment.leading) { _ in
                            0
                        }
                }
                
                Text("Incoming Meetups")
                    .frame(width: screen.width, height: screen.height*0.10, alignment: .center)
                    .background(.indigo)
                    .padding()
                
                Spacer()
            }
            .navigationTitle(club.id!)
        }
    }
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        ClubView(club: Clubs(id: "", Coordinator: "", ClubDescription: "", Helpful_Information: [], Meetups: [], RequiredEquipment: [], forumID: -1, members: []))
    }
}
