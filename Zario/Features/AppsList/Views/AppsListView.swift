//
//  AppsListView.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import SwiftUI
import FamilyControls
import DeviceActivity

public extension DeviceActivityReport.Context {
    static let pieChart = Self("Pie Chart")
    static let barGraph = Self("barGraph")
}

struct AppsListContentView: View {
    @State private var pickerIsPresented = false
    @ObservedObject var model: ScreenTimeSelectAppsModel
    @State var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State var filter = DeviceActivityFilter()
    
    var body: some View {
        VStack {
            Button("Select Apps To Block") {
                pickerIsPresented = true
            }.familyActivityPicker(
                isPresented: $pickerIsPresented,
                selection: $model.activitySelection
            )
            Spacer()
                VStack {
                    Text("Apps Activities")
                    DeviceActivityReportView(context: context, filter: filter)
                }
            }
        }.padding(50)
        
    }
}
