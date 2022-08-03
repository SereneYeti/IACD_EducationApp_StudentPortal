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
    @EnvironmentObject var viewModel:ChatroomsViewModel
    @State var joinModel = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack
                {
                    Button(action : {
                        self.mode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "arrow.left.circle.fill")
                    }
                    .padding(.leading)
                    //.frame(alignment: .leading)
                    
                    Spacer()
                    
                    Text("Join a chatroom")
                        .font(.title)
                        .fontWeight(.bold)
                        //.frame(alignment: .center)
                        .padding(.top)
                    
                    Spacer()
                }
                .frame(width:screen.width, alignment: .topLeading)
                List(viewModel.allChatrooms, id: \.self){ chatroom in
                    if(chatroom.type == 2){
                        
                        HStack {
                                Text(chatroom.title)
                                Spacer()
                            Button {
                                viewModel.joinChatroom(code: chatroom.joinCode) {
                                    self.joinModel = false
                                }
                            } label: {
                                Image(systemName: "plus.message")
                            }
                        }
                    }
                }
                .padding(.bottom)
                .padding(.top)
                
                VStack {
                    Text("Create a chatroom")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: screen.width, alignment: .center)
                    TextField("Enter a new title", text: $newTitle)
                        .padding(4)
                        .frame(width: screen.width*0.85,alignment: .center)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(color: .gray, radius: 2, x: 3, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.indigo, lineWidth: 2)
                                .opacity(0.7)
                                
                        )
                                                
                        .padding()
                    Button(action: {
                        viewModel.createStudentChatroom(title: newTitle, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("Create")
                    })
                }
                .padding(.top)
            }
            .background(Color(red: 244/255, green: 243/255, blue: 248/255))
            //.navigationBarTitle("Join or create")
            .navigationBarHidden(true)
        }
    }
}

struct JoinChatroomView_Previews: PreviewProvider {
    static var previews: some View {
        JoinChatroomView(isOpen: .constant(true))
    }
}
