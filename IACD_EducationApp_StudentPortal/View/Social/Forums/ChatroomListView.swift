//
//  ChatroomListView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/24.
//

import SwiftUI

struct ChatroomListView: View {
    @ObservedObject var viewModel =  ChatroomsViewModel()
    @State var joinModel = false
    
    
    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
       // NavigationView{
        VStack (spacing: 1){
            Text("My Forums")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .alignmentGuide(.leading) { _ in
                    0
            }
            List(viewModel.chatrooms){ chatroom in
                NavigationLink(destination: MessagesView(chatroom: chatroom)){
                    HStack {
                        Text(chatroom.title)
                        Spacer()
                    }
                }
            }
            //.navigationBarTitle("Forums")
            .navigationBarItems(trailing: Button(action: {
                self.joinModel = true
            }, label: {
                Image(systemName: "plus.circle")
            }))
            .sheet(isPresented: $joinModel, content: {
                JoinChatroomView(isOpen: $joinModel)
            })
        }
            
        //}
    }
}

struct ChatroomListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatroomListView()
    }
}
