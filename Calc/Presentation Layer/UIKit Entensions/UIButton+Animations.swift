//
//  UIButton+Animations.swift
//  Calc
//
//  Created by Hyuk Kim on 8/19/24.
//

import Foundation
import UIKit

extension UIButton {
    func bounce() {
        moveUpWithSpringDamping()
    }
    
    func moveUpWithSpringDamping() {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { _ in
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: [.curveEaseInOut, .allowUserInteraction]) { [weak self] in
                self?.transform = CGAffineTransform.identity
            } completion: { _ in
            }
        }
    }
}
