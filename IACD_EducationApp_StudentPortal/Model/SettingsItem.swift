//
//  SettingsItem.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/23.
//

import Foundation
import SwiftUI

struct SettingsItem: Identifiable{
    var id = UUID()
    var text: String
    var icon: Image
    var menu: SelectedSetting
}

    //setting the selection
enum SelectedSetting: String{
    case editProfile
    case billing
    case contact
    case moreInfo
    case logOut
    case darkmode
}

var settingItems1 = [
    SettingsItem(text: "Edit Profile", icon: Image(systemName: "pencil") , menu: .editProfile),
    SettingsItem(text: "Finances", icon: Image(systemName: "creditcard") , menu: .billing)
]

var settingsItems2 = [
    SettingsItem(text: "Contacts", icon: Image(systemName: "book.closed") , menu: .contact),
    SettingsItem(text: "Help", icon: Image(systemName: "questionmark") , menu: .moreInfo),
    SettingsItem(text: "Log Out", icon: Image(systemName: "door.left.hand.open") , menu: .logOut)
]

