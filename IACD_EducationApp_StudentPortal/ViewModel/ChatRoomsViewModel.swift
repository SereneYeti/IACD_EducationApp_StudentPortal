//
//  ChatRoomsViewModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Chatroom: Codable, Identifiable, Hashable{
    var id:String
    var title:String
    var joinCode:Int
    var type:Int //type 0 will be clubs 1 will be degrees and 2 will be student made forums & -1 will mean an error
    var section:String
    
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
                    let type = data["type"] as? Int ?? -1
                    let section = data["section"] as? String ?? ""
                    return Chatroom(id: docId, title: title, joinCode: joinCode,type: type, section: section)
                })
            })
        }
        
        print("JOIN CODE: \(createJoinCode())")
        //RandomNumberGenerator.GenerateRanodmNumber(numberOfDigits: 6, arrayToCheck: [])
        //print("Staff ID: \(RandomNumberGenerator.randomNumberGenerated)")
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
    
    func createStudentChatroom(title: String, handler: @escaping () -> Void) {
        if (user != nil) {
            CheckJoinCodes()
            RandomNumberGenerator.GenerateRanodmNumber(numberOfDigits: 5, arrayToCheck: self.chatroomJoinCodes)
            db.collection("chatrooms").addDocument(data: [
                "title": title,
                "joinCode": RandomNumberGenerator.randomNumberGenerated,
                "type": 2,
                "section": "Student Made",
                "users": [user!.uid]]) { err in
                    if let err = err {
                        print("error adding document! \(err)")
                    } else {
                        handler()
                    }
                    
                }
        }
    }
    
    func createClubChatroom(title: String, handler: @escaping () -> Void, joinCode:Int) {
        if (user != nil) {
            //CheckJoinCodes()
            db.collection("chatrooms").addDocument(data: [
                "title": title,
                "joinCode": joinCode,
                "type": 0,
                "section": "Clubs",
                "users": []]) { err in
                    if let err = err {
                        print("error adding document! \(err)")
                    } else {
                        handler()
                    }
                    
                }
        }
    }
    
    func createDegreeChatroom(title: String, handler: @escaping () -> Void, joinCode:Int) {
        if (user != nil) {
            //CheckJoinCodes()
            db.collection("chatrooms").addDocument(data: [
                "title": title,
                "joinCode": joinCode,
                "type": 1,
                "section": "Degree",
                "users": []]) { err in
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
    
    func GetChatroomsInTypes() -> [[Chatroom]]{
        var ans:[[Chatroom]] = [[],[],[]]
        chatrooms.forEach { chatroom in
            ans[chatroom.type].append(chatroom)
        }
        
        return ans
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
