//
//  RootRouter.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func attach(mainView: UIView)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  mainRouter: MainRouting) {
        self.mainRouter = mainRouter
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        routeToMain()
    }
    
    private func routeToMain() {
        attachChild(mainRouter)
        
        if let view = mainRouter.viewControllable.uiviewController.view {
            viewController.attach(mainView: view)
        }
    }
    
    let mainRouter: MainRouting
}
