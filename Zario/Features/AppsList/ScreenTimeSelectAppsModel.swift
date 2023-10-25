//
//  ScreenTimeSelectAppsModel.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import Foundation
import FamilyControls

class ScreenTimeSelectAppsModel: ObservableObject {
    @Published var activitySelection = FamilyActivitySelection()

    init() { }
}
