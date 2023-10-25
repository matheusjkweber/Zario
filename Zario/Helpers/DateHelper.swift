//
//  DateHelper.swift
//  Zario
//
//  Created by Matheus Weber on 24/10/23.
//

import Foundation

class DateHelper {
    static let shared = DateHelper()
    
    func getLastWeekInterval() -> DateInterval {
        let lastWeekDate = Calendar(identifier: .iso8601).date(byAdding: .weekOfYear, value: -1, to: Date())!
        return DateInterval(start: lastWeekDate, end: Date())
    }
}
