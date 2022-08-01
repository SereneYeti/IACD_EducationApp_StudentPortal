//
//  UpcomingClubsTaskView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/31.
//

import SwiftUI

struct UpcomingClubsTaskView: View {
    @State var newTask = false
    @State var currentClub:Clubs?
    @EnvironmentObject var clubViewModel:ClubsViewModel
    @EnvironmentObject var taskModel: TaskViewModel
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                //ForEach(, id: \.self){ task in
                ClubTaskView(taskTitle: "Title", taskDescription: "Description", taskDate: Date.now)
                // }
                Button(action: {
                    self.newTask = true
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
            .sheet(isPresented: self.$newTask, content: {NewTaskClubs() .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(taskModel).environmentObject(clubViewModel)})
        }
    }
}

struct ClubTaskView:View{
    
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    @State var taskDate: Date = Date()
    
    var body: some View{
        VStack{
            Text(taskTitle)
                .font(.headline)
                .fontWeight(.bold)
            Text(taskDescription)
                .font(.subheadline)
                .fontWeight(.regular)
            Text(taskDate.description)
                .font(.footnote)
                .fontWeight(.bold)
            
        }
        .padding()
        .background(.bar)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
        )
        .padding()
    }
}

struct UpcomingClubsTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingClubsTaskView()
    }
}
