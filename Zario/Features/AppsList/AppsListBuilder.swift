//
//  AppsListBuilder.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs

protocol AppsListDependency: Dependency {
    var mutableShieldAppStreaming: MutableShieldAppStreaming { get }
}

final class AppsListComponent: Component<AppsListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppsListBuildable: Buildable {
    func build(withListener listener: AppsListListener) -> AppsListRouting
}

final class AppsListBuilder: Builder<AppsListDependency>, AppsListBuildable {

    override init(dependency: AppsListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AppsListListener) -> AppsListRouting {
        let component = AppsListComponent(dependency: dependency)
        let viewController = AppsListViewController()
        let interactor = AppsListInteractor(presenter: viewController, mutableShieldAppStream: component.dependency.mutableShieldAppStreaming)
        interactor.listener = listener
        return AppsListRouter(interactor: interactor, viewController: viewController)
    }
}
