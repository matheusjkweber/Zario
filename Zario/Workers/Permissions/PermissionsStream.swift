//
//  PermissionsStream.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import Foundation
import RxSwift
import RxRelay

public enum PermissionsError: Error {
    case errorOnRequestScreenTimePermission(Error)
    case nonCoveredCase
}

public enum ScreenTimePermission {
    case notDetermined
    case approved
    case denied
}

public protocol PermissionsStreaming {
    var screenTimePermissionStatus: Observable<ScreenTimePermission> { get }
}

public protocol MutablePermissionsStreaming: PermissionsStreaming {
    func update(screenTimePermissionStatus: ScreenTimePermission)
    func onScreenTimePermission(error: Error)
}

final class PermissionsStream: MutablePermissionsStreaming {
    var screenTimePermissionStatus: Observable<ScreenTimePermission> {
        screenTimePermissionStatusPublishSubject.asObservable()
    }
    var screenTimePermissionStatusPublishSubject = BehaviorSubject<ScreenTimePermission>(value: .notDetermined)
    
    func update(screenTimePermissionStatus: ScreenTimePermission) {
        screenTimePermissionStatusPublishSubject.onNext(screenTimePermissionStatus)
    }
    
    func onScreenTimePermission(error: Error) {
        screenTimePermissionStatusPublishSubject.onError(error)
    }
}
