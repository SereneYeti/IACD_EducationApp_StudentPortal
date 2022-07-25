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
    @Published var graphicModules = [Module]()
    let db = Firestore.firestore()
    
    init(){
        fetchData()
        fetchGraphicDesignData()
    }
    
        //MARK: Fetch data items
    func fetchData(){
        
        db.collection("Student").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                        //                    print("\(document.documentID): \(document.data())")
                    let data = document.data()
                    let studentNumber = data["studentNum"] as? Int ?? 0
                    let studentID = data["studentID"] as? Int ?? 0
                    let studentFirstName = data["firstName"] as? String ?? ""
                    let studentLastName = data["lastName"] as? String ?? ""
                    
                    self.students.append(Student(id: document.documentID,
                                                 studentNum: studentNumber,
                                                 studentID: studentID,
                                                 firstName: studentFirstName,
                                                 lastName: studentLastName))
                }
            }
        }
    }
    
    
    func fetchGraphicDesignData(){
        db.collection("GraphicDesign").getDocuments { modDocs, error in
            if let error = error{
                print("Error getting documents: \(error)")
            }else{
                for document in modDocs!.documents{
                    let data = document.data()
                    
                    self.graphicModules.append(Module(name: data["name"] as? String ?? "",
                                                      lecturer: data["lecturer"] as? String ?? "",
                                                      color: data["color"] as? String ?? "",
                                                      image: data["image"] as? String ?? "",
                                                      description: data["description"] as? String ?? "",
                                                      Content: data["[Content]"] as? [String] ?? [],
                                                      ContentTitles: data["[ContentTitles]"] as? [String] ?? []))
                    
                    //print(self.graphicModules.count)
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
