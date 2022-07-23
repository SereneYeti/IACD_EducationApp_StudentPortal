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
    @Published var students = [Student]()
 
        //get refrence to data
    private let db = Firestore.firestore()
    init(){
        getStudentData()
    }
    
        //MARK: Fetch data items
    func getStudentData(){

        
            //read documents at a path
        db.collection("Student").getDocuments { snapshot, error in
                //Error check
//            guard let documents  = snapshot?.documents else {
//                print("no students")
//                return
//            }
//
//            self.students = documents.map { (QueryDocumentSnapshot) -> Student in
//                let data = QueryDocumentSnapshot.data()
//
//                let docID = QueryDocumentSnapshot.documentID
//                let stuID = data["studentID"] as? Int ?? 0
//                let firstN = data["firstName"] as? String ?? ""
//                let lastN = data["lastName"] as? String ?? ""
//                let stuNum = data["studentNum"] as? Int ?? 0
//
//                return Student(id: docID, studentNum: stuNum, studentID: stuID, firstName: firstN, lastName: lastN)
//            }

            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            //get documents and create students
                        self.students = snapshot.documents.map { doc  in
                            //Create student
                            return Student(id: doc.documentID,
                                           studentNum: doc["studentNum"] as? Int ?? 0,
                                           studentID: doc["studentID"] as? Int ?? 0,
                                           firstName: doc["firstName"] as? String ?? "",
                                           lastName: doc["lastName"] as? String ?? "" )
                        }
                    }
                }
            }else{
                    //handle error

            }
        }
    }
}
let  testData = [
    Student(id: "559594", studentNum: 2813083, studentID: 38193849, firstName: "Jack", lastName: "LinkerMan"),
    Student(id: "473947", studentNum: 27492497, studentID: 47924794, firstName: "Tracy", lastName: "Ross"),
    Student(id: "353463", studentNum: 158941789, studentID: 4289749, firstName: "Jamie", lastName: "Tart")
]
