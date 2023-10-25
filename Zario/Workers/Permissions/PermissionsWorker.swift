//
//  PermissionsWorker.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import Foundation
import RIBs
import FamilyControls

final class PermissionsWorker: Worker {
    private var mutablePermissionStreaming: MutablePermissionsStreaming
    let ac = AuthorizationCenter.shared
    
    init(mutablePermissionStreaming: MutablePermissionsStreaming) {
        self.mutablePermissionStreaming = mutablePermissionStreaming
    }
    
    override func didStart(_ interactorScope: InteractorScope) {
        requestPermission()
    }
    
    func requestPermission() {
        Task {
            do {
                try await ac.requestAuthorization(for: .individual)
                await self.handlePermissionChanged()
            }
            catch {
                await self.handleError(error)
            }
        }
     
    }
    
    @MainActor
    func handlePermissionChanged() {
        print(ac.authorizationStatus)
        switch ac.authorizationStatus {
        case .notDetermined:
            self.mutablePermissionStreaming.update(screenTimePermissionStatus: .notDetermined)
        case .denied:
            self.mutablePermissionStreaming.update(screenTimePermissionStatus: .denied)
        case .approved:
            self.mutablePermissionStreaming.update(screenTimePermissionStatus: .approved)
        @unknown default:
            self.mutablePermissionStreaming.onScreenTimePermission(error: PermissionsError.nonCoveredCase)
        }
    }
    
    @MainActor
    func handleError(_ error: Error) {
        self.mutablePermissionStreaming.onScreenTimePermission(error: PermissionsError.errorOnRequestScreenTimePermission(error))
    }
    
}
