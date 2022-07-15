//
//  NewTask.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/15.
//

import SwiftUI
//MARK: View for user to define the new task they'll be adding

struct NewTask: View {
    @Environment(\.dismiss) var dismiss
    
    //MARK: Task Values
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: Date = Date()
    
    //MARK: Core data Context
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        NavigationView{
            List{
                Section {
                    TextField("Go to work", text: $taskTitle)
                } header: {
                    Text("Task Title")
                }
                Section {
                    TextField("What type of work", text: $taskDescription)
                } header: {
                    Text("Task Description")
                }
                Section {
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                } header: {
                    Text("Task Date")
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add New task")
            .navigationBarTitleDisplayMode(.inline)
            
            //MARK: Disabling the view with swipe action
            .interactiveDismissDisabled()
            
            //MARK: Action Buttons
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        //MARK: Create a new entity , which will create our new object in core Date
                        let task = Task(context: context)
                        task.taskTitle = taskTitle
                        task.taskDescription = taskDescription
                        task.taskDate = taskDate
                        
                        //Saving
                        try? context.save()
                        dismiss()
                    }
                    .disabled(taskTitle == "" || taskDescription == "")
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Canel"){
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask()
    }
}
