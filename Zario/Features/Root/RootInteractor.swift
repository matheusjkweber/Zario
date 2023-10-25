//
//  RootInteractor.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?
    private var workers = [Working]()
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: RootPresentable,
         workers: [Working]) {
        self.workers = workers
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        startWorkers()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func startWorkers() {
        for worker in workers {
            worker.start(self)
        }
    }
}
