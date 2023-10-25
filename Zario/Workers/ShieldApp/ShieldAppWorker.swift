//
//  ShieldAppWorker.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import Foundation
import RIBs
import FamilyControls
import ManagedSettings
import Combine
import DeviceActivity

final class ShieldAppWorker: Worker {
    private var mutableShieldAppStream: MutableShieldAppStreaming
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    private let userDefaultsKey = "ScreenTimeSelection"
    let store = ManagedSettingsStore()
    let deviceMonitor = DeviceMonitor()
    
    init(mutableShieldAppStream: MutableShieldAppStreaming) {
        self.mutableShieldAppStream = mutableShieldAppStream
    }
    
    override func didStart(_ interactorScope: InteractorScope) {
        subscribeToStreams()
    }
    
    func subscribeToStreams() {
        mutableShieldAppStream.shieldApps.subscribe(onNext: { selection in
            self.save(selection)
            self.deviceMonitor.startDeviceMonitoring(with: selection)
        }).disposeOnStop(self)
    }
    
    func save(_ selection: FamilyActivitySelection) {
        let defaults = UserDefaults.standard
        defaults.set(
            try? encoder.encode(selection),
            forKey: userDefaultsKey
        )
        store.shield.applications = selection.applicationTokens
    }
        
    func savedSelection() -> FamilyActivitySelection? {
        let defaults = UserDefaults.standard

        guard let data = defaults.data(forKey: userDefaultsKey) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        return try? decoder.decode(
            FamilyActivitySelection.self,
            from: data
        )
    }
    
    
}

class DeviceMonitor: DeviceActivityMonitor {
    let center = DeviceActivityCenter()
    func startDeviceMonitoring(with selection: FamilyActivitySelection) {
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
            repeats: true
        )
        let timeLimitMinutes = 30

        let event = DeviceActivityEvent(
            applications: selection.applicationTokens,
            categories: selection.categoryTokens,
            webDomains: selection.webDomainTokens,
            threshold: DateComponents(minute: timeLimitMinutes)
        )
        
        center.stopMonitoring()
        
        let activity = DeviceActivityName("MyApp.ScreenTime")
        let eventName = DeviceActivityEvent.Name("MyApp.SomeEventName")
        do {
            try center.startMonitoring(
                activity,
                during: schedule,
                events: [
                    eventName: event
                ]
            )
        } catch {
            //HANDLE ERROR
        }
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        let schedule = DeviceActivityCenter().schedule(for: activity)
        let nextInterval = schedule?.nextInterval
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)

        // Notify the user that they're approaching the time limit
        let schedule = DeviceActivityCenter().schedule(for: activity)
        let warningTime = schedule?.warningTime
    }
}
