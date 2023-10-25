//
//  ShieldAppStream.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import Foundation
import RxSwift
import RxRelay
import FamilyControls

public protocol ShieldAppStreaming {
    var shieldApps: Observable<FamilyActivitySelection> { get }
}

public protocol MutableShieldAppStreaming: ShieldAppStreaming {
    func update(selection: FamilyActivitySelection)
}

final class ShieldAppStream: MutableShieldAppStreaming {
    var shieldApps: Observable<FamilyActivitySelection> {
        shieldAppsPublishSubject.asObservable()
    }
    var shieldAppsPublishSubject = PublishSubject<FamilyActivitySelection>()
    
    func update(selection: FamilyActivitySelection) {
        shieldAppsPublishSubject.onNext(selection)
    }
}
