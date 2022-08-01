    //
    //  CalendarHome.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/07/13.
    //
    //Notes
    ///EEE will return as Mon, Tue, Wed

import SwiftUI

struct CalendarHome: View {
    @EnvironmentObject var taskModel: TaskViewModel
    @Namespace var animation
    
    //MARK: Core Data Context
    @Environment(\.managedObjectContext) var context
    
    //MARK: Edit button Context
    @Environment(\.editMode) var editButton
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section{
                        //MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 10) {
                            
                            ForEach(taskModel.currentWeek, id: \.self){ day in
                                VStack(spacing: 10) {
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                    
                                }
                                    //MARK: Foreground Style
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                                    //MARK: Capsule Shape
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack{
                                            //MARK: Matched geometry animation
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                        
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                        //Updating Current Day
                                    withAnimation(.easeInOut) {
                                        taskModel.currentDay = day
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    TasksView()
                } header: {
                        //MARK: Header
                    CalendarHeaderView()
                    
                }
            }
            .environment(\.editMode, editButton)
        }
        .ignoresSafeArea(.container, edges: .top)
        //MARK: Add Button
        .overlay(
            Button(action: {
                taskModel.addNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black, in: Circle())
            })
            .padding(),
            alignment: .bottomTrailing
        )
        .sheet(isPresented: $taskModel.addNewTask) {
            //Clear task
            taskModel.editTask = nil
        } content: {
            NewTask()
                .environmentObject(taskModel)
        }
    }
        //MARK: Tasks View
        ///update when another date is pressed
    func TasksView() -> some View{
        LazyVStack(spacing: 20){
            
            //Converting object as our task model
            DynamicFilteredView(dateToFilter: taskModel.currentDay) { (object : Task) in
                
                TaskCardView(task: object)
            }
        }
        .padding()
        .padding(.top)
    }
        //MARK: Task Card View
    func TaskCardView(task: Task) -> some View {
        
        //MARK: CoreData Will give optional data
        
        HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 30){
            //If edit mode is enabled show delete button
            if editButton?.wrappedValue == .active{
                
                // Edit button for now and future
                VStack( spacing: 10) {
                    
                    if task.taskDate?.compare(Date()) == .orderedAscending || Calendar.current.isDateInToday(task.taskDate ?? Date()){
                        Button {
                            taskModel.editTask = task
                            taskModel.addNewTask.toggle()
                            
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button {
                        //deleting task
                        context.delete(task)
                        
                        //Saving delete
                        try? context.save()
                        
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
                

            }
            else{
                VStack(spacing: 15){
                    Circle()
                        .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? (task.isCompleted ? .green : .black ) : .clear)
                        .frame(width: 15, height: 15)
                        .background(
                            Circle()
                                .stroke(.black,lineWidth: 1)
                                .padding(-3)
                        )
                        .scaleEffect(!taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.7 : 1)
                    Rectangle()
                        .fill(.black)
                        .frame(width:3)
                }
            }
                VStack{
                    HStack(alignment: .top, spacing: 10) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(task.taskTitle ?? "")
                                .font(.title2.bold())
                            
                            Text(task.taskDescription ?? "")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                        .hLeading()
                        Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
                    }
                    
                    //MARK: Team Members or others
                    ///If statement removes team members and the check if the task is complete
                    if taskModel.isCurrentHour(date: task.taskDate ?? Date()){
                    HStack(spacing: 12) {
             
                        //MARK: Check Button
                        if !task.isCompleted {
                            Button{
                                //update task status
                                task.isCompleted = true
                                
                                //saving information
                                try? context.save()
                            }label: {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                                    .padding(10)
                                    .background(Color.white, in: RoundedRectangle(cornerRadius: 20))
                            }
                        }
                        
                        Text(task.isCompleted ? "Completed" : "Check to complete")
                            .font(.system(size: task.isCompleted ? 14 : 16, weight: .light))
                            .foregroundColor(task.isCompleted ? .gray :.white)
                            .hLeading()
                    }
                    .padding(.top)
                    }
                    
                }
                .foregroundStyle(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .black.opacity(0.9))
                .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 15 : 0)
                .padding(.bottom, taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0 :10 )
                .hLeading()
                .background(
                    Color.black
                        .cornerRadius(25)
                        .opacity(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 1 : 0)
                )
        }
        .hLeading()
        .padding(.vertical,5)
        .navigationBarHidden(true)
    }
        
}




struct CalendarHome_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHome()
    }
}
