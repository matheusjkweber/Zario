//
//  MainInteractor.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs
import RxSwift

protocol MainRouting: ViewableRouting {
    func routeToAppsList()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    func presentLoading()
    func presentError()
    func presentDenied()
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?
    private let mutablePermissionStream: MutablePermissionsStreaming
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: MainPresentable,
         mutablePermissionStream: MutablePermissionsStreaming) {
        self.mutablePermissionStream = mutablePermissionStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        requestScreentimePermission()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func requestScreentimePermission() {
        presenter.presentLoading()
        mutablePermissionStream.screenTimePermissionStatus.subscribe(onNext: { permission in
            switch permission {
            case .approved:
                self.router?.routeToAppsList()
            case .denied:
                self.presenter.presentDenied()
            case .notDetermined:
                self.presenter.presentLoading()
            }
        }, onError: { error in
            self.presenter.presentError()
        }).disposeOnDeactivate(interactor: self)
    }
    
    func goToSettingsButton() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
