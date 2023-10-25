//
//  AppComponent.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
