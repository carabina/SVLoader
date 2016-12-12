//
//  OvalLayer.swift
//  Loader
//
//  Created by Slava Semeniuk on 12/12/16.
//  Copyright © 2016 Slava Semeniuk. All rights reserved.
//

import UIKit

class OvalLayer: CAShapeLayer {
    
    var centralPoint: CGPoint!
    
    convenience init(center: CGPoint) {
        self.init()
        fillColor = UIColor.white.cgColor
        centralPoint = center
        path = ovalPath.cgPath
    }
    
    var ovalPath: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: centralPoint.x, y: centralPoint.y, width: 8, height: 8))
    }
    
    var expandedOvalPath: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: centralPoint.x - 2, y: centralPoint.y - 2, width: 12, height: 12))
    }
    
    func startAnimatingInA(seconds: CFTimeInterval) {
        let expandAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = ovalPath.cgPath
        expandAnimation.toValue = expandedOvalPath.cgPath
        expandAnimation.beginTime = seconds
        expandAnimation.duration = 0.2
        
        let shrinkAnimation = CABasicAnimation(keyPath: "path")
        shrinkAnimation.fromValue = expandedOvalPath.cgPath
        shrinkAnimation.toValue = ovalPath.cgPath
        shrinkAnimation.beginTime = expandAnimation.duration + expandAnimation.beginTime
        shrinkAnimation.duration = 0.2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [expandAnimation, shrinkAnimation]
        animationGroup.duration = expandAnimation.beginTime + shrinkAnimation.duration + shrinkAnimation.duration
        animationGroup.fillMode = kCAFillModeForwards
        add(animationGroup, forKey: nil)
    }
}
