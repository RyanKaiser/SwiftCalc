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
        moveUp()
    }
    
    func growLarger() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
        }
    }
    
    func moveUp() {
        let imageView = UIImageView()
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.transform = CGAffineTransform(translationX: 0, y: -50)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
                self.transform = CGAffineTransform(translationX: 0, y: 0)
            } completion: { _ in
                
                
            }

        }

    }
    
    
}
