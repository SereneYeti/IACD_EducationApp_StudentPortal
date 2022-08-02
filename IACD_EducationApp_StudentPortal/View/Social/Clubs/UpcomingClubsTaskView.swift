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
        
        if(currentClub != nil){
            Button(action: {
                self.newTask = true
            }, label: {
                Image(systemName: "plus.circle")
            })
            .sheet(isPresented: self.$newTask, content: {NewTaskClubs(club: currentClub!, strClub: currentClub!.id!) .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(taskModel).environmentObject(clubViewModel)})
        }
        
    }
}

struct UpcomingClubsTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingClubsTaskView()
    }
}
