//
//  Newsletter.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by Christopher on 2022/08/01.
//

import SwiftUI

struct NewsletterView: View {
    var body: some View {
        Image("newsletter")
            .resizable()
            .ignoresSafeArea()
    }
}

struct Newsletter_Previews: PreviewProvider {
    static var previews: some View {
        NewsletterView()
    }
}
