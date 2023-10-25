//
//  UIView+Ext.swift
//  Zario
//
//  Created by Matheus Weber on 23/10/23.
//

import UIKit

extension UIView {
    func setShadow(opacity: Float = 0.5, blur: CGFloat = 4,  radius: CGFloat = 0, offset: CGSize = .init(width: 0, height: 2), color: UIColor = .lightGray) {
        layer.cornerRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowRadius = blur / 2.0
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
    }
    
    func disableAllSubViews() {
        let disabledColor = UIColor.gray
        
        switch self {
        case is UILabel:
            (self as? UILabel)?.textColor = disabledColor
        case is UIImageView:
            let imgView = (self as? UIImageView)
            imgView?.image = imgView?.image?.withRenderingMode(.alwaysTemplate)
            imgView?.tintColor = disabledColor
        case is UIControl:
            (self as? UIControl)?.isEnabled = false
        default:
            if backgroundColor != nil {
                backgroundColor = disabledColor
            }
        }
        
        if layer.borderColor != nil {
            layer.borderColor = disabledColor.cgColor
        }
        subviews.forEach({ $0.disableAllSubViews() })
    }
    
    func blink(numberOfFlashes: Float) {
       let flash = CABasicAnimation(keyPath: "opacity")
       flash.duration = 0.2
       flash.fromValue = 1
       flash.toValue = 0.1
       flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
       flash.autoreverses = true
       flash.repeatCount = numberOfFlashes
       layer.add(flash, forKey: nil)
   }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
    func removeSubviews(_ views: [UIView]) {
        views.forEach { view in
            view.removeFromSuperview()
        }
    }
}
