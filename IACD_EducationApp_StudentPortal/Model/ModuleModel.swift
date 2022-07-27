//
//  ModuleModel.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/26.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

//MARK: For the content in the module
struct Content: Codable, Hashable {
    var contentTitle: String?
    var contentBody: String?
}

//MARK: For the tasks in the module
struct Tasks: Codable, Hashable{
    var taskTitle: String?
    var taskBody: String?
}

struct Module: Codable , Identifiable{
    @DocumentID var id: String?
    var name: String?
    var lecturer: String?
    var image: String?
    var color: String?
    var tasks: [Tasks]?
    var content: [Content]?
}

extension Module {
    static let empty = Module(name: "", lecturer: "", image: "", color: "ffcdb2", tasks: [], content: [])
    static let sample = Module(name: "Brand and Marketing",
                               lecturer: "Demi Swart",
                               image: "https://dl.dropboxusercontent.com/s/rqpo34ve4apmj3u/Conversion%20rate%20optimization-amico.png?dl=0",
                               color: "ffcdb2",
                               tasks: [Tasks(taskTitle: "start", taskBody: "Do some work"),
                                       Tasks(taskTitle: "end", taskBody: "Final project")],
                               content: [ Content(contentTitle: "Start", contentBody: "first module"),
                                          Content(contentTitle: "End", contentBody: "last module")])
}


