//
//  MainBuilder.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs

protocol MainDependency: Dependency {
    var mutablePermissionsStream: MutablePermissionsStreaming { get }
    var mutableShieldAppStream: MutableShieldAppStreaming { get }
}

final class MainComponent: Component<MainDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> MainRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        let interactor = MainInteractor(presenter: viewController, mutablePermissionStream: component.dependency.mutablePermissionsStream)
        interactor.listener = listener
        let appsListRouter = AppsListBuilder(dependency: component).build(withListener: interactor)
        return MainRouter(interactor: interactor, viewController: viewController, appsListRouter: appsListRouter)
    }
}
