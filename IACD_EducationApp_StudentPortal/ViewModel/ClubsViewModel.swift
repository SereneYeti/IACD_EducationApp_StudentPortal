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

struct Clubs: Codable, Identifiable{
    var id: String?
    var Coordinator:String?
    var ClubDescription:String?
    var Helpful_Information:[Helpful_Information]?
    var Meetups:[Timestamp]?
    var RequiredEquipment:[String]?
    var forumID:Int?
    var members:[String]?
    
    enum CodingKeys:String,CodingKey{
        case id
        case Coordinator
        case ClubDescription = "Description"
        case Helpful_Information
        case Meetups
        case RequiredEquipment
        case forumID
        case members
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

class ClubsViewModel: ObservableObject{
    @Published var allClubs = [Clubs]()
    @Published var userClubs = [Clubs]()
    @Published var gottenClubs:Bool = false
    @Published var club:Clubs?
    private var clubIDs:[String] = []
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    private var errorMessage:String = ""
    
    public let joinClub = Clubs(Coordinator: "JoinClub", ClubDescription: "Join a club to meet new people and learn neew things.", Helpful_Information: [], Meetups: [], RequiredEquipment: [], forumID: -1, members: [])
    
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
    
    func GetAllClubs(){
        if(user != nil){
            db.collection("Clubs").getDocuments { (snapshot, error) in 
                snapshot?.documents.forEach({ (document) in
                    let docID = document.documentID
                    self.clubIDs.append(docID)
                })
                
                self.clubIDs.forEach { id in
                    print("Club ID: \(id)")
                    self.fetchDataForClub(clubID: id)
                   
                }
                
                self.allClubs.forEach { club in
                    print("CLUBS 123: \(club.Coordinator!)")
                }
                
                //self.allClubs.remove(at: 0)
                
                
                
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
                }
                
            }
        }
    }
    
    func GetUserClubAtIndex(index:Int)->Clubs{
        return userClubs[index]
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
