//
//  MainViewController.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import RIBs
import RxSwift
import UIKit
import SwiftUI

protocol MainViewing: UIView {
    func attachMainView(view: UIView)
}

protocol StatesViewing: UIView {
    
}

protocol MainPresentableListener: AnyObject {
    func goToSettingsButton()
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {

    weak var listener: MainPresentableListener?
    private let mainView: MainViewing = MainView()
    private var currentView: StatesViewing = PermissionsView(state: .asking)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = mainView
        view.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
    }
    
    func presentLoading() {
        self.presentPermissionsView(with: .asking)
    }
    
    func presentError() {
        self.presentPermissionsView(with: .error)
    }
    
    func presentDenied() {
        self.presentPermissionsView(with: .denied)
    }
    
    private func changeView(_ showView: StatesViewing) {
        showView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        currentView = showView
        view = showView
    }
    
    private func presentPermissionsView(with state: PermissionViewState) {
        let permissionsView = PermissionsView(state: state)
        permissionsView.delegate = self
        changeView(permissionsView)
    }
    
    func presentAppsList(viewController: ViewControllable) {
        viewController.uiviewController.isModalInPresentation = true
        self.present(viewController.uiviewController, animated: true)
    }
}

extension MainViewController: PermissionsViewDelegate {
    func handleGoToSettingsButton() {
        
    }
}
