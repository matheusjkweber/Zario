//
//  MainComponents.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import Foundation

extension MainComponent: AppsListDependency {
    var mutableShieldAppStreaming: MutableShieldAppStreaming {
        dependency.mutableShieldAppStream
    }
}
