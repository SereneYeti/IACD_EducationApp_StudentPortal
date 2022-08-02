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
                               content: [ Content(contentTitle: "What is a brand ?", contentBody: "first module"),
                                          Content(contentTitle: "End", contentBody: "last module")])

}

extension Tasks{
    static let empty = Tasks(taskTitle: "", taskBody: "")
    static let sample = Tasks(taskTitle: "Main title",
                                  taskBody: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut venenatis vulputate magna, at tempor ligula dignissim et. Suspendisse a ligula ipsum. Proin eu dictum elit, et semper tortor. Donec malesuada mauris neque, non tristique nibh venenatis in. Maecenas nec sapien ac massa bibendum cursus non nec arcu. Cras efficitur tempor varius. Cras porttitor pellentesque accumsan. Morbi eu lorem sit amet diam ultricies ultricies. Quisque porttitor vitae dolor ut tincidunt. Sed nisi turpis, egestas at ex eget, convallis suscipit nunc.")
}


