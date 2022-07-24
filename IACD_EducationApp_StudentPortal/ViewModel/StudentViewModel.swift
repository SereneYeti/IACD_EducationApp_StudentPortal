    //
    //  StudentViewModel.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/07/21.
    //
    /// `MAP` goes through the array and performs actions on each element in the array and returns the result in a collection

import Foundation
import Firebase

class StudentModel: ObservableObject {
    @Published var student: String = ""
 

    init(){
        fetchData()
    }
    
        //MARK: Fetch data items
    func fetchData(){
        let db = Firestore.firestore()
        
        let docRef = db.collection("Student").document("studentOne")
        docRef.getDocument { document, error in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.student = data["name"] as? String ?? ""
                }
            }
        }
    }
}
let  testData = [
    Student(id: "559594", studentNum: 2813083, studentID: 38193849, firstName: "Jack", lastName: "LinkerMan"),
    Student(id: "473947", studentNum: 27492497, studentID: 47924794, firstName: "Tracy", lastName: "Ross"),
    Student(id: "353463", studentNum: 158941789, studentID: 4289749, firstName: "Jamie", lastName: "Tart")
]
