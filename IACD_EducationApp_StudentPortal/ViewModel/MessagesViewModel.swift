//
//  MessagesViewModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Message: Codable, Identifiable{
    var id: String?
    var content: String
    var name: String
}

class MessagesViewModel: ObservableObject{
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func sendMessage(messageContent: String,docId: String){
        if(user != nil){
            db.collection("chatrooms").document(docId).collection("messages").addDocument(data: ["sentAt": Date(),
                                                                                                 "displayName": user!.email!,
                                                                                                 "content": messageContent,
                                                                                                 "sender": user!.uid])
        }
    }
    
    func fetchData(docId: String) {
           if (user != nil) {
               db.collection("chatrooms").document(docId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener({(snapshot, error) in
                   guard let documents = snapshot?.documents else {
                       print("no documents")
                       return
                   }
                   
                   self.messages = documents.map { docSnapshot -> Message in
                       let data = docSnapshot.data()
                       let docId = docSnapshot.documentID
                       let content = data["content"] as? String ?? ""
                       let displayName = data["displayName"] as? String ?? ""
                       return Message(id: docId, content: content, name: displayName)                       
                   }
               })
           }
       }
    
}
