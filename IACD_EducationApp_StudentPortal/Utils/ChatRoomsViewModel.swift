//
//  ChatRoomsViewModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Chatroom: Codable, Identifiable{
    var id:String
    var title:String
    var joinCode:Int
    
}

class ChatroomsViewModel: ObservableObject{
    
    @Published var chatrooms = [Chatroom]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func fetchData(){
        if(user != nil){
            db.collection("chatrooms").whereField("users", arrayContains: user!.uid).addSnapshotListener({ [self](snapshot,error) in
                guard let documents = snapshot?.documents else {
                    print("No docs returned!")
                    return
                }
                
                self.chatrooms = documents.map({docSnapshot -> Chatroom in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let title = data["title"] as? String ?? "Chatroom"
                    let joinCode = data["joinCode"] as? Int ?? -1
                    return Chatroom(id: docId, title: title, joinCode: joinCode)
                })
            })
            
            
        }
    }
    
    func createChatroom(title: String, handler: @escaping () -> Void) {
            if (user != nil) {
                RandomNumberGenerator.GenerateRanodmNumber(numberOfDigits: 6, arrayToCheck: [])
                db.collection("chatrooms").addDocument(data: [
                                                        "title": title,
                                                        "joinCode": RandomNumberGenerator.randomNumberGenerated,
                                                        "users": [user!.uid]]) { err in
                    if let err = err {
                        print("error adding document! \(err)")
                    } else {
                        handler()
                    }
                    
                }
            }
        }
        
        func joinChatroom(code: String, handler: @escaping () -> Void) {
            if (user != nil) {
                db.collection("chatrooms").whereField("joinCode", isEqualTo: Int(code)).getDocuments() { (snapshot, error) in
                    if let error = error {
                        print("error getting documents! \(error)")
                    } else {
                        for document in snapshot!.documents {
                            self.db.collection("chatrooms").document(document.documentID).updateData([
                                                                                                        "users": FieldValue.arrayUnion([self.user!.uid])])
                            handler()
                        }
                    }
                    
                }
            }
        }
    
    
}
