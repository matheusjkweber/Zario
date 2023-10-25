//
//  PieChartReport.swift
//  Zario
//
//  Created by Matheus Weber on 24/10/23.
//

import SwiftUI
import DeviceActivity
import ManagedSettings

struct PieChartReport: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .pieChart
    let content: (PieChartView.Configuration) -> PieChartView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> PieChartView.Configuration {
        print(data)
        var totalUsedByCategory: [ActivityCategory: TimeInterval] = [:]
        return PieChartView.Configuration(totalUsageByCategory: totalUsedByCategory)
    }
}

struct PieChartView: View {
    struct Configuration {
        let totalUsageByCategory: [ActivityCategory: TimeInterval]
    }
    
    let configuration: Configuration
    
    var body: some View {
        Text("Test")
//        PieChart(usage: configuration.totalUsageByCategory)
    }
}
