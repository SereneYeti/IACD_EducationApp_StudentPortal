//
//  extensions.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/13.
//


import SwiftUI

extension View{
    
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .trailing)
    }
    
    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity,alignment: .center)
    }
    
    //MARK: Safe area
    
}
