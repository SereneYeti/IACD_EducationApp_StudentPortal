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
    private var chatroomJoinCodes:[Int] = []
    
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
        
        print("JOIN CODE: \(createJoinCode())")
    }
    
    func CheckJoinCodes(){
        if user != nil {
            db.collection("chatrooms").whereField("joinCode", isGreaterThanOrEqualTo: 0).getDocuments { [self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No docs returned!")
                    return
                }
                
                self.chatroomJoinCodes = documents.map({ docSnapshot -> Int in
                    let data = docSnapshot.data()
                    return data["joinCode"] as? Int ?? -1
                })
                
                print("Chatroom join Codes: \(self.chatroomJoinCodes)")
                
            }
        }
    }
    
    func createChatroom(title: String, handler: @escaping () -> Void) {
            if (user != nil) {
                CheckJoinCodes()
                RandomNumberGenerator.GenerateRanodmNumber(numberOfDigits: 5, arrayToCheck: self.chatroomJoinCodes)
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
    
    func createJoinCode() -> Int{
        var joinCode:Int = -1
        if(user != nil){
            CheckJoinCodes()
            RandomNumberGenerator.GenerateRanodmNumber(numberOfDigits: 5, arrayToCheck: self.chatroomJoinCodes)
            joinCode = RandomNumberGenerator.randomNumberGenerated
        }
        
        return joinCode
    }
        
        func joinChatroom(code: Int, handler: @escaping () -> Void) {
            if (user != nil) {
                db.collection("chatrooms").whereField("joinCode", isEqualTo: code).getDocuments() { (snapshot, error) in
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
