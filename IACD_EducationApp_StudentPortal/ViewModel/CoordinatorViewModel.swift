//
//  CoordinatorViewModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/08/01.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Coordinator: Codable, Identifiable, Hashable{
    var id:String?
    var name:String
    var ContactNumber:Int
    var staffID:Int
    
    enum CodingKeys:CodingKey{
        case id
        case name
        case ContactNumber
        case staffID
    }
    
}

class CoordinatorViewModel:ObservableObject{
    @Published var Coordinators = [Coordinator]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    private var errorMessage:String = ""
    
    func fetchDataForStaffMember(staffID:String){
        var ans:Coordinator?
        if(user != nil){
            let docRef = db.collection("Staff").document(staffID)
            
            docRef.getDocument { document, error in
                if let error = error as NSError? {
                    self.errorMessage = "Error getting document: \(error.localizedDescription)"
                }
                else {
                    if let document = document {
                        do {
                            ans = try document.data(as: Coordinator.self)
                            print("Coordinator: \(ans?.name ?? "error")")
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
