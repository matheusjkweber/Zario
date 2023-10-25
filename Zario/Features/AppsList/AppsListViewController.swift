//
//  AppsListViewController.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs
import RxSwift
import UIKit
import SwiftUI
import DeviceActivity

protocol AppsListPresentableListener: AnyObject {
}

final class AppsListViewController: UIViewController, AppsListPresentable, AppsListViewControllable {

    weak var listener: AppsListPresentableListener?
    var rootView = AppsListContentView(model: ScreenTimeSelectAppsModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func presentView(model: ScreenTimeSelectAppsModel) {
        rootView.model = model
        let controller = UIHostingController(rootView: rootView)
        addChild(controller)
        view.addSubview(controller.view)
        controller.view.frame = view.frame
        controller.didMove(toParent: self)
    }
    
    func presentListWith(filter: DeviceActivityFilter) {
        rootView.filter = filter
    }
}
