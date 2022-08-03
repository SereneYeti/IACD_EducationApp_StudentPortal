//
//  StartView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/13.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var viewModel:AppViewModel
    
    var body: some View{
        NavigationView{
            if viewModel.signedIn{
                ContentView().environmentObject(viewModel)
            }
            else
            {
                StartPageMock().environmentObject(viewModel)
            }
        }.onAppear{
            viewModel.signedIn = viewModel.isSignedIn
            //print("viewModel: \(viewModel.signedIn)")
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(AppViewModel())
    }
}
