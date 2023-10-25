//
//  PrimaryButton.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import UIKit

public class PrimaryButton: CustomButton {
    
    public override var isEnabled: Bool {
        didSet {
            self.backgroundColor = self.isEnabled ? .black : .lightGray
        }
    }

    public override var buttonType: UIButton.ButtonType {
        return .custom
    }

    public override func configureViews() {
        self.backgroundColor = .black
        titleLabel?.font = .systemFont(ofSize: 18)
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .disabled)
        setShadow(radius: 6.0)
    }
}
