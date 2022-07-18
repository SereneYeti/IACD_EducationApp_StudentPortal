//
//  CalendarView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/06/22.
//

import SwiftUI

struct CalendarView: View {
    let persistenceController = PersistenceController.shared
    var body: some View {
        CalendarHome()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .navigationBarHidden(true)
    }
}

struct CalendarView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
        
        CalendarView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
          
    }
}
let persistenceController = PersistenceController.shared
