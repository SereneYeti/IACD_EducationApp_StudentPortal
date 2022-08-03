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
    
    @EnvironmentObject var taskModel: TaskViewModel
    
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
                    //Disable when editing
                if taskModel.editTask == nil {
                    Section {
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    } header: {
                        Text("Task Date")
                    }
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
                        if let task  = taskModel.editTask{
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                            
                        }else {
                                //MARK: Create a new entity , which will create our new object in core Date
                            _ = CreateTask()
                        }
                        
                            //Saving
                        try? context.save()
                        dismiss()
                    }
                    .disabled(taskTitle == "" || taskDescription == "")
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
                // loading task data if from edit
            .onAppear{
                if let task = taskModel.editTask {
                    taskTitle = task.taskTitle ?? ""
                    taskDescription = task.taskDescription ?? ""
                    
                }
            }
        }
    }
    
    func CreateTask()->Task{
        
        let task = Task(context: context)
        
        task.taskTitle = taskTitle
        task.taskDescription = taskDescription
        task.taskDate = taskDate
        
        return task
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask()
    }
}
