//
//  ChatroomListView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/24.
//

import SwiftUI

struct ChatroomListView: View {
    @EnvironmentObject var forumsViewModel:ChatroomsViewModel
    @State var joinModel = false
    @State private var singleSelection: UUID?
    
    
    
    
    var body: some View {
        // NavigationView{
        VStack (spacing: 1){
            HStack{
                Text("My Forums")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(alignment: .center)
                    .padding()
                
                Button(action: {
                    self.joinModel = true
                }, label: {
                    Image(systemName: "plus.circle")
                })
                .frame(alignment: .trailing)
            }
            .frame(width:screen.width)
            
            List(forumsViewModel.GetChatroomsInTypes(), id: \.self){ chatrooms in
                if(chatrooms.count > 0){
                    Section(header: Text(chatrooms[0].section)) {
                        ForEach(chatrooms, id: \.self){ chatroom in
                            NavigationLink(destination: MessagesView(chatroom: chatroom)){
                                HStack {
                                    Text(chatroom.title)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $joinModel, content: {
                JoinChatroomView(isOpen: $joinModel)
            })
        }
        .background(Color(red: 244/255, green: 243/255, blue: 248/255))
    }
}


struct ChatroomListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatroomListView()
    }
}
