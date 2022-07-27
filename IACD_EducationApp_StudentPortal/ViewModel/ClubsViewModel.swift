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
    var Coordinator:String
    var ClubDescription:String
    var Helpful_Information:[Helpful_Information]
    var Meetups:[Timestamp]
    var RequiredEquipment:[String]
    var forumID:Int
    var members:[String]
    
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

struct Helpful_Information:Codable, Hashable{
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
    @Published var clubs = [Clubs]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    private var errorMessage:String = ""
    
    public let joinClub = Clubs(Coordinator: "", ClubDescription: "Join a club to meet new people and learn neew things.", Helpful_Information: [], Meetups: [], RequiredEquipment: [], forumID: -1, members: [])
    
    func fetchDataForClub(clubID:String) -> Clubs{
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
        
        return ans ?? joinClub
    }
    
    func fetchDataForUserClubs(clubID:String){
        if(user != nil){
            let docRef = db.collection("Clubs").document(clubID)
            
            docRef.getDocument { document, error in
                if let error = error as NSError? {
                    self.errorMessage = "Error getting document: \(error.localizedDescription)"
                }
                else {
                    if let document = document {
                        do {
                            let club = try document.data(as: Clubs.self)
                            if(club.members.contains(self.user!.uid)){
                                self.clubs.append(club)
                            }
                            print("Clubs: \(self.clubs[0].Helpful_Information[0])")
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
    
    func fetchUserClubs(){
        if(user != nil){
            db.collection("Clubs").whereField("members", arrayContains: user!.uid).addSnapshotListener({ [self](snapshot,error) in
                guard let documents = snapshot?.documents else {
                    print("No docs returned!")
                    return
                }
                
                self.clubs = documents.map({docSnapshot -> Clubs in
                    do {
                        let clubTest = try docSnapshot.data(as: Clubs.self)
                        print("Club Test: \(clubTest.Coordinator)")
                        return clubTest
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
                        return joinClub
                    }
                    
                })
                print("Club Count: \(clubs.count)")
                print("Club Coordinadtor: \(clubs[1].Coordinator)")
            })
            
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
    
    func GetClubAtIndex(index:Int)->Clubs{
        return clubs[index]
    }
}
