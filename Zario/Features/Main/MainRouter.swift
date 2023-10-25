//
//  MainRouter.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs

protocol MainInteractable: Interactable, AppsListListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    func presentAppsList(viewController: ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    let appsListRouter: AppsListRouting
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: MainInteractable, viewController: MainViewControllable, appsListRouter: AppsListRouting) {
        self.appsListRouter = appsListRouter
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToAppsList() {
        attachChild(appsListRouter)
        viewController.presentAppsList(viewController: appsListRouter.viewControllable)
    }
}
