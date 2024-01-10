//
//  UIView+Extension.swift
//  Radius
//
//  Created by Kavyashree Hegde on 29/06/23.
//

import UIKit

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0.1)
        gradient.endPoint = CGPoint(x :0.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
