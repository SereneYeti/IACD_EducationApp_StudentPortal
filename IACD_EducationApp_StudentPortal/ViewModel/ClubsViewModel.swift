//
//  ClubsViewModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/26.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct Clubs: Codable, Identifiable{
    var id: String?
    var Coordinator:Int?
    var ClubDescription:String?
    var Helpful_Information:[Helpful_Information]?
    var RequiredEquipment:[String]?
    var Images:[Images]?
    var forumID:Int?
    var members:[String]?
    
    enum CodingKeys:String,CodingKey{
        case id
        case Coordinator
        case ClubDescription = "Description"
        case Helpful_Information
        case RequiredEquipment        
        case Images
        case forumID
        case members
    }
    
}

struct Meetups:Codable, Identifiable, Hashable{
    var id:String?
    var timestamp:String?
    var description:String?
    var title:String?
    
    enum CodingKeys:CodingKey{
        case id
        case timestamp
        case description
        case title
    }
}

struct Helpful_Information:Codable, Identifiable ,Hashable{
    var id:String?
    var name:String
    var link:String
    var infoDescription:String
    
    enum CodingKeys:String,CodingKey{
        case id
        case name = "Name"
        case link = "Link"
        case infoDescription = "Description"
    }
}

struct Images:Codable, Identifiable, Hashable{
    var id:String?
    var URL:String?
    var credit:String?
    
    enum CodingKeys:String,CodingKey{
        case id
        case URL
        case credit
    }
}

class ClubsViewModel: ObservableObject{
    @Published var allClubs = [Clubs]()
    @Published var userClubs = [Clubs]()
    
    private var clubIDs:[String] = []
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    private var errorMessage:String = ""
    
    public let joinClub = Clubs(Coordinator: -1, ClubDescription: "Join a club to meet new people and learn neew things.", Helpful_Information: [], RequiredEquipment: [],Images: [], forumID: -1, members: [])
    
    func fetchDataForClub(clubID:String){
        var ans:Clubs?
        if(user != nil){
            let docRef = db.collection("Clubs").document(clubID)
            
            docRef.getDocument { document, error in
                if let error = error as NSError? {
                    self.errorMessage = "Error getting document: \(error.localizedDescription)"
                }
                else {
                    if let document = document {
                        do {
                            ans = try document.data(as: Clubs.self)
                            self.allClubs.append(ans!)
                            if(ans!.members!.contains(self.user!.uid)){
                                self.userClubs.append(ans!)
                            }
                        }
                        catch {
                            switch error {
                            case DecodingError.typeMismatch(_, let context):
                                self.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                            case DecodingError.valueNotFound(_, let context):
                                self.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                            case DecodingError.keyNotFound(_, let context):
                                self.errorMessage = "\(error.localizedDescription): \(context.debugDescription)"
                            case DecodingError.dataCorrupted(let key):
                                self.errorMessage = "\(error.localizedDescription): \(key)"
                            default:
                                self.errorMessage = "Error decoding document: \(error.localizedDescription)"
                            }
                        }
                    }
                }
            }
        }
    }
    
    func AddNewClubDocument(id:String, Coordinator: Int, ClubDescription:String, Helpful_Information: [Helpful_Information], Meetups: [Timestamp], RequiredEquipment: [String], Images: [Images], forumID: Int, members: [String]){
        
        let newClub = Clubs(id: id, Coordinator: Coordinator, ClubDescription: ClubDescription, Helpful_Information: Helpful_Information, RequiredEquipment: RequiredEquipment, Images: Images, forumID: forumID, members: members)
        
        do {
            try db.collection("Clubs").document(String(id)).setData(from: newClub)
            print("New Club created \(newClub.id ?? "error") added!")
        } catch let error {
            print("Error writing new club to Firestore: \(error)")
        }
    }
    
    func GetNewForumID(forumIDs:[Int]){
        RandomNumberGenerator.GenerateRanodmNumber(numberOfDigits: 5, arrayToCheck: forumIDs)
    }
    
    func GetAllClubs(){
        self.allClubs.removeAll()
        
        if(user != nil){
            db.collection("Clubs").getDocuments { (snapshot, error) in
                snapshot?.documents.forEach({ (document) in
                    let docID = document.documentID
                    self.clubIDs.append(docID)
                })
                
                self.clubIDs.forEach { id in
                    //print("Club ID: \(id)")
                    self.fetchDataForClub(clubID: id)
                }
            }
            
        }
    }
    
    
    func joinClub(clubID:String) {
        if (user != nil) {
            db.collection("Clubs").getDocuments() { (snapshot, error) in
                if let error = error {
                    print("error getting documents! \(error)")
                } else {
                    self.db.collection("Clubs").document(clubID).updateData([
                        "members": FieldValue.arrayUnion([self.user!.uid])])
                    self.AddClubToUserArray(ClubID: clubID)
                    //self.userClubs.append()
                }
                
            }
            
            //GetAllClubs()
        }
    }
    
    private func AddClubToUserArray(ClubID:String){
        self.allClubs.forEach { club in
            if(club.id == ClubID){
                userClubs.append(club)
                print("Added member to \(ClubID) Club")
            }
        }
    }
    
    func GetUserClubs(){
        self.userClubs.removeAll()
        DispatchQueue.main.async {
            
            self.GetAllClubs()
            
            self.allClubs.forEach { club in
                print("User uid: \(self.user!.uid)")
                print("Members: \(club.members!)")
                if(club.members!.contains(self.user!.uid)){
                    self.userClubs.append(club)
                    print(club)
                    print("User uid: \(self.user!.uid)")
                }
            }
        }
    }
    
    func GetUserClubAtIndex(index:Int)->Clubs{
        return userClubs[index]
    }
    
    func InClub(ClubID:String) -> Bool{
        var ans:Bool = false
        userClubs.forEach({ c in
            if(c.id! == ClubID){
                ans = true
            }
            
        })
        
        return ans
    }
    
    /* OLD
     func fetchUserClubs() {
     if(user != nil){
     db.collection("Clubs").whereField("members", arrayContains: user!.uid).addSnapshotListener({ [self](snapshot,error) in
     guard let documents = snapshot?.documents else {
     print("No docs returned!")
     return
     }
     
     self.userClubs = documents.map({docSnapshot -> Clubs in
     let data = docSnapshot.data()
     let docId = docSnapshot.documentID
     let Coordinator = data["Coordinator"] as? String ?? ""
     let Description = data["Description"] as? String ?? ""
     
     //print("Club info: \(test)")
     
     let Meetups = data["Meetups"] as? [Timestamp] ?? []
     let RequiredEquipment = data["RequiredEquipment"] as? [String] ?? []
     let forumID = data["forumID"] as? Int ?? -1
     let members = data["members"] as? [String] ?? []
     return Clubs(id: docId,Coordinator: Coordinator, ClubDescription: Description, Helpful_Information: [] , Meetups: Meetups, RequiredEquipment: RequiredEquipment, forumID: forumID, members: members)
     })
     print("Club Coordinator 0: \(userClubs[0].Helpful_Information!.count)")
     print("Club Coordinator 1: \(userClubs[1].Helpful_Information!.count)")
     print("Club Equirpment 0: \(userClubs[0].RequiredEquipment![0])")
     print("Club Equirpment 1: \(userClubs[1].RequiredEquipment![1])")
     })
     }
     }
     */
}
