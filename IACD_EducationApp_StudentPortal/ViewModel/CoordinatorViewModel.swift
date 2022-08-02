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
    var name:String?
    var ContactNumber:Int?
    var staffID:Int?
    var image:String?
    
    enum CodingKeys:CodingKey{
        case id
        case name
        case ContactNumber
        case staffID
        case image
    }
    
}

class CoordinatorViewModel:ObservableObject{
    @Published var Coordinators = [Coordinator]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    private var errorMessage:String = ""
    private var coordinatorIDs:[Int] = []
    
    init(){
        //AddNewStaffMemberDocument(staffID: GetNewStaffID(), Name: "Eben Kok", ContatNumber: 27765552533, ImageURL: "https://cbsnews1.cbsistatic.com/hub/i/2017/08/22/1611291e-8783-4d73-a86d-5760a3dd781e/gettyimages-699007336.jpg")
        GetAllCoordinators()
    }
    
    func GetStaffInfo(staffId:Int) -> Coordinator{
        var ans = Coordinator(name: "", ContactNumber: -1, staffID: -1, image: "")
        Coordinators.forEach { c in
            if(c.staffID == staffId){
                ans = c
            }
        }
        
        return ans
    }
    
    func AddNewStaffMemberDocument(staffID:Int, Name: String, ContatNumber:Int, ImageURL:String){
        let newStaff = Coordinator(name: Name, ContactNumber: ContatNumber, staffID: staffID, image: ImageURL)
        
        do {
            try db.collection("Staff").document(String(staffID)).setData(from: newStaff)
            print("New Staff member \(newStaff.name) added!")
        } catch let error {
            print("Error writing staff member to Firestore: \(error)")
        }
    }
    
    func GetNewStaffID() -> Int{
        RandomNumberGenerator.GenerateRanodmNumber(numberOfDigits: 6, arrayToCheck: coordinatorIDs)
        return RandomNumberGenerator.randomNumberGenerated
    }
    
    private func fetchDataForStaffMember(staffID:String){
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
                            self.Coordinators.append(ans!)
                            
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
    
    func GetAllCoordinators(){
        
        if(user != nil){
            db.collection("Staff").getDocuments { (snapshot, error) in
                snapshot?.documents.forEach({ (document) in
                    let docID = document.documentID
                    if(!docID.isEmpty){
                        self.coordinatorIDs.append(Int(docID)!)
                    }
                })
                
                self.coordinatorIDs.forEach { id in
                    //print("Club ID: \(id)")
                    self.fetchDataForStaffMember(staffID: String(id))
                }
            }
            
        }
    }
    
}
