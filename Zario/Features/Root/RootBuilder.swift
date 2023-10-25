//
//  RootBuilder.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {
    lazy var permissionWorker: PermissionsWorker = {
        PermissionsWorker(mutablePermissionStreaming: mutablePermissionsStream)
    }()
    
    lazy var mutablePermissionsStream: MutablePermissionsStreaming = {
        PermissionsStream()
    }()
    
    lazy var permissionsStream: PermissionsStreaming = {
        mutablePermissionsStream
    }()
    
    lazy var shieldAppWorker: ShieldAppWorker = {
        ShieldAppWorker(mutableShieldAppStream: mutableShieldAppStream)
    }()
    
    lazy var mutableShieldAppStream: MutableShieldAppStreaming = {
        ShieldAppStream()
    }()
    
    lazy var shieldAppStream: ShieldAppStreaming = {
        mutableShieldAppStream
    }()
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build(withListener listener: RootListener) -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RootListener) -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController, workers: [component.permissionWorker, component.shieldAppWorker])
        let mainRouter = MainBuilder(dependency: component).build(withListener: interactor)
        interactor.listener = listener
        return RootRouter(interactor: interactor, viewController: viewController, mainRouter: mainRouter)
    }
}
