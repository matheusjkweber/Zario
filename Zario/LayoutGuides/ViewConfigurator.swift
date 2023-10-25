//
//  ViewConfigurator.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import UIKit

public protocol ViewConfigurator: AnyObject {
    func setup()
    func prepareViews()
    func addViewHierarchy()
    func setupConstraints()
    func configureViews()
    func configureBindings()
}

extension ViewConfigurator {
    public func setup() {
        prepareViews()
        addViewHierarchy()
        setupConstraints()
        configureViews()
        configureBindings()
    }
}
