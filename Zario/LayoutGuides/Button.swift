//
//  Button.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import UIKit

open class CustomButton: UIButton, ViewConfigurator {
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func prepareViews() {}
    open func addViewHierarchy() {}
    open func setupConstraints() {}
    open func configureViews() {}
    open func configureBindings() {}

    private var pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
    
    func pulse() {
        pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.toValue = 1.2
        pulseAnimation.duration = 1.0
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        self.layer.add(pulseAnimation, forKey: "pulsing")
    }
    
    func pulse(forSeconds seconds: Int) {
        pulse()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(seconds)) {
            DispatchQueue.main.async {
                self.layer.removeAllAnimations()
            }
        }
    }
}
