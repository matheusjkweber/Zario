//
//  WorklogReport.swift
//  Zario
//
//  Created by Matheus Weber on 24/10/23.
//

import DeviceActivity
import SwiftUI

struct WorklogReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        PieChartReport { configuration in
            PieChartView(configuration: configuration)
        }
    }
}
