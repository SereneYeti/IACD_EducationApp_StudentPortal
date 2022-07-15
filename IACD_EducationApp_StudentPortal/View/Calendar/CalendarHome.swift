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
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
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
        }
        .ignoresSafeArea(.container, edges: .top)
    }
        //MARK: Tasks View
        ///update when another date is pressed
    func TasksView() -> some View{
        LazyVStack(spacing: 20){
            
            if let tasks = taskModel.filteredTasks{
                if tasks.isEmpty{
                    Text("You have no Tasks")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                } else{
                    ForEach(tasks){ task in
                        TaskCardView(task: task)
                    }
                }
                
            }else{
                    //MARK: No tasks for today
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        
            //MARK: Updating Tasks
        .onChange(of: taskModel.currentDay) { newValue in
            taskModel.filterTodayTasks()
        }
    }
        //MARK: Task Card View
    func TaskCardView(task: Task) -> some View {
        HStack(alignment: .top, spacing: 30){
            
            VStack(spacing: 15){
                Circle()
                    .fill(taskModel.isCurrentHour(date: task.taskDate) ? .black : .clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black,lineWidth: 1)
                            .padding(-3)
                    )
                    .scaleEffect(!taskModel.isCurrentHour(date: task.taskDate) ? 0.7 : 1)
                Rectangle()
                    .fill(.black)
                    .frame(width:3)
            }
                VStack{
                    HStack(alignment: .top, spacing: 10) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(task.taskTitle)
                                .font(.title2.bold())
                            
                            Text(task.taskDescription)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                        .hLeading()
                        Text(task.taskDate.formatted(date: .omitted, time: .shortened))
                    }
                    
                    //MARK: Team Members or others
                    ///If statement removes team members and the check if the task is complete
                    if taskModel.isCurrentHour(date: task.taskDate){
                    HStack(spacing: 0) {
                        HStack(spacing: -10){
                            ForEach(0 ..< 3) { item in
                                Image("Avatar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .stroke(.black,lineWidth: 5)
                                    )
                            }
                        }
                        .hLeading()
                        
                        //MARK: Check Button
                        Button{
                            
                        }label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.black)
                                .padding(10)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .padding(.top)
                    }
                    
                }
                .foregroundStyle(taskModel.isCurrentHour(date: task.taskDate) ? .white : .black.opacity(0.9))
                .padding(taskModel.isCurrentHour(date: task.taskDate) ? 15 : 0)
                .padding(.bottom, taskModel.isCurrentHour(date: task.taskDate) ? 0 :
                            10 )
                .hLeading()
                .background(
                    Color.black
                        .cornerRadius(25)
                        .opacity(taskModel.isCurrentHour(date: task.taskDate) ? 1 : 0)
                )
        }
        .hLeading()
        .padding(.vertical,5)
    }
}




struct CalendarHome_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHome()
    }
}
