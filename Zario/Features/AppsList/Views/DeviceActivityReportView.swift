//
//  DeviceActivityReportView.swift
//  Zario
//
//  Created by Matheus Weber on 24/10/23.
//

import Foundation
import SwiftUI
import ManagedSettings
import FamilyControls
import DeviceActivity

public struct DeviceActivityReportView: View {
    @State public var context: DeviceActivityReport.Context = .barGraph
    @State public var filter: DeviceActivityFilter

    public var body: some View {
        VStack {
            DeviceActivityReport(context, filter: filter)


            // A picker used to change the report's context.
            Picker(selection: $context, label: Text("Context: ")) {
                Text("Bar Graph")
                    .tag(DeviceActivityReport.Context.barGraph)
                Text("Pie Chart")
                     .tag(DeviceActivityReport.Context.pieChart)
            }


            // A picker used to change the filter's segment interval.
            Picker(
                selection: $filter.segmentInterval,
                 label: Text("Segment Interval: ")
            ) {
                Text("Hourly")
                    .tag(DeviceActivityFilter.SegmentInterval.hourly())
                Text("Daily")
                    .tag(DeviceActivityFilter.SegmentInterval.daily(
                        during: Calendar.current.dateInterval(
                             of: .weekOfYear, for: .now
                        )!
                    ))
                Text("Weekly")
                    .tag(DeviceActivityFilter.SegmentInterval.weekly(
                        during: Calendar.current.dateInterval(
                            of: .month, for: .now
                        )!
                    ))
            }
            // ...
        }
    }
}
