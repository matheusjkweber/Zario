//
//  MainView.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import UIKit
import SnapKit

class MainView: UIView, MainViewing {
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Must not be initialized with this init")
    }
    
    private func setupView() {
        addSubview(containerView)
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func attachMainView(view: UIView) {
        containerView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
