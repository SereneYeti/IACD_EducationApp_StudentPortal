//
//  ModuleViewModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/26.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class ModuleViewModule: ObservableObject{
    @Published var module: Module = .empty
    @Published var errorMessage: String?
    @Published var modules = [Module]()
    
    private var db = Firestore.firestore()
    
    init() {
//        fetchAndMap()
        fetchAllData()
    }
    
    func fetchAndMap() {
        fetchModule(documentId: "Brand and Marketing 1A")
    }
    
    func fetchAllData(){
        db.collection("Modules").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.modules = documents.compactMap{(queryDocumentSnapshot) -> Module? in
                return try? queryDocumentSnapshot.data(as: Module.self)
            }
//            print(self.modules.count)
//            for mods in self.modules{
//                print(mods.lecturer ?? "")
//            }
        }
    }
    
    private func fetchModule(documentId: String){
        let docRef = db.collection("Modules").document(documentId)
        docRef.getDocument(as: Module.self) { result in
            switch result {
            case .success(let module):
                self.module = module
                                
                self.errorMessage = nil
            case .failure(let error):
                    // A Module value could not be initialized from the DocumentSnapshot.
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
