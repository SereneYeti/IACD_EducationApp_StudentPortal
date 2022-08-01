//
//  MessagesView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/24.
//

import SwiftUI

struct MessagesView: View {
    
    let chatroom: Chatroom
    @ObservedObject var viewModel = MessagesViewModel()
    @State var messageField:String = ""
    
    init(chatroom: Chatroom){
        self.chatroom = chatroom
        viewModel.fetchData(docId: chatroom.id)
    }
    
    var body: some View {
        VStack{
            List(viewModel.messages){ message in
                HStack{
                    Text(message.content)
                    Spacer()
                }
            }
            HStack{
                TextField("Enter Message", text:  $messageField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    viewModel.sendMessage(messageContent: messageField, docId: chatroom.id)
                    messageField = ""
                }, label: {
                    Text("Send")
                })
            }
        }
            .navigationBarTitle(chatroom.title)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(chatroom: Chatroom(id: "10101", title: "Hello!", joinCode: 0,type: 2,section: "User Generated"))
    }
}
