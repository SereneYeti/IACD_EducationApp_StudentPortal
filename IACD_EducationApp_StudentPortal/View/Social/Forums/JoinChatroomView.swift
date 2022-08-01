//
//  JoinChatroomView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/24.
//

import SwiftUI

struct JoinChatroomView: View {
    @Binding var isOpen: Bool
    @State var joinCode = ""
    @State var newTitle = ""
    @ObservedObject var viewModel = ChatroomsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Join a chatroom")
                        .font(.title)
                    TextField("Enter your join code", text: $joinCode)
                    Button(action: {
                        viewModel.joinChatroom(code: Int(joinCode) ?? -1, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("Join")
                    })
                }
                .padding(.bottom)
                
                VStack {
                    Text("Create a chatroom")
                        .font(.title)
                    TextField("Enter a new title", text: $newTitle)
                    Button(action: {
                        viewModel.createChatroom(title: newTitle, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("Create")
                    })
                }
                .padding(.top)
            }
            .navigationBarTitle("Join or create")
        }
    }
}

struct JoinChatroomView_Previews: PreviewProvider {
    static var previews: some View {
        JoinChatroomView(isOpen:  .constant(true))
    }
}
