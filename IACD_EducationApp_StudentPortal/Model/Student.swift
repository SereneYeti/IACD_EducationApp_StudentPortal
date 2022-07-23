//
//  Student.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/21.
//

import Foundation

struct Student: Codable, Identifiable{
    
    var id: String //holds doc id
    var studentNum: Int
    var studentID: Int
    var firstName: String
    var lastName: String
    
}
