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
    
    func fetchData(clubID:String){
        if(user != nil){
            let docRef = db.collection("Clubs").document(clubID)

              docRef.getDocument { document, error in
                if let error = error as NSError? {
                  self.errorMessage = "Error getting document: \(error.localizedDescription)"
                }
                else {
                  if let document = document {
                    do {
                        self.clubs.append(try document.data(as: Clubs.self))
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
}
