//
//  AppsListRouter.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs

protocol AppsListInteractable: Interactable {
    var router: AppsListRouting? { get set }
    var listener: AppsListListener? { get set }
}

protocol AppsListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AppsListRouter: ViewableRouter<AppsListInteractable, AppsListViewControllable>, AppsListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AppsListInteractable, viewController: AppsListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
