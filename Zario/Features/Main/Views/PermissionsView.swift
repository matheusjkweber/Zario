//
//  AskingPermissionsView.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import UIKit
import SnapKit

enum PermissionViewState {
    case asking
    case notDetermined
    case denied
    case error
}

protocol PermissionsViewDelegate: AnyObject {
    func handleGoToSettingsButton()
}

class PermissionsView: UIView, StatesViewing {
    weak var delegate: PermissionsViewDelegate?
    let state: PermissionViewState
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .placeholderGray
        return view
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.text = String(localized: "Asking for permissions")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var goToSettingsButton: PrimaryButton = {
        let button = PrimaryButton()
        button.isEnabled = true
        button.setTitle("Go to Settings", for: .normal)
        button.addTarget(self, action: #selector(handleGoToSettingsButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    init(state: PermissionViewState) {
        self.state = state
        super.init(frame: CGRect.zero)
        setupView()
        setupLayout()
        setupStateConfigs()
    }
    
    override init(frame: CGRect) {
        self.state = .asking
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Must not be initialized with this init")
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(goToSettingsButton)
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(16.0)
            make.right.equalTo(-16.0)
            make.centerY.equalToSuperview()
        }
        
        goToSettingsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.top.equalTo(titleLabel.snp.bottom).offset(16.0)
        }
    }
    
    private func setupStateConfigs() {
        switch state {
        case .denied:
            titleLabel.text = "The permissions were denied, please go to the config and allow them."
            goToSettingsButton.isHidden = false
        case .notDetermined:
            titleLabel.text = "Unable to retrieve permissions state, please go to the config and allow them."
            goToSettingsButton.isHidden = false
        case .error:
            titleLabel.text = "Error on retrieve permissions state, please go to the config and allow them."
            goToSettingsButton.isHidden = false
        default:
            break
        }
    }
    
    @objc
    func handleGoToSettingsButtonTapped(_ sender: Any) {
        delegate?.handleGoToSettingsButton()
    }
}
