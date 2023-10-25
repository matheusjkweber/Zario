//
//  AppsListInteractor.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs
import RxSwift
import SwiftUI
import FamilyControls
import Combine
import ManagedSettings
import DeviceActivity

protocol AppsListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AppsListPresentable: Presentable {
    var listener: AppsListPresentableListener? { get set }
    func presentView(model: ScreenTimeSelectAppsModel)
    func presentListWith(filter: DeviceActivityFilter)
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AppsListListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppsListInteractor: PresentableInteractor<AppsListPresentable>, AppsListInteractable, AppsListPresentableListener {

    weak var router: AppsListRouting?
    weak var listener: AppsListListener?
    let mutableShieldAppStream: MutableShieldAppStreaming
    private var screentimeModel = ScreenTimeSelectAppsModel()
    private var cancellables = Set<AnyCancellable>()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: AppsListPresentable, mutableShieldAppStream: MutableShieldAppStreaming) {
        self.mutableShieldAppStream = mutableShieldAppStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        subscribeToActivitySelection()
        presenter.presentView(model: screentimeModel)
        // TODO: Implement business logic here.
    }

    func subscribeToActivitySelection() {
        screentimeModel.$activitySelection.sink { selection in
            if !selection.applications.isEmpty {
                self.mutableShieldAppStream.update(selection: selection)
                self.buildFilterAndPresentList(selection: selection)
            }
        }
        .store(in: &cancellables)
    }
    
    func buildFilterAndPresentList(selection: FamilyActivitySelection) {
        let selectedApps = selection.applicationTokens
        let selectedCategories = selection.categoryTokens
        let selectedWebDomains = selection.webDomainTokens
        
        let filter = DeviceActivityFilter(
            segment: .daily(
                during: Calendar.current.dateInterval(
                   of: .weekOfYear, for: .now
                )!
            ),
            users: .children,
            devices: .init([.iPhone, .iPad]),
            applications: selectedApps,
            categories: selectedCategories,
            webDomains: selectedWebDomains
        )
        
        
        presenter.presentListWith(filter: filter)
    }
}
