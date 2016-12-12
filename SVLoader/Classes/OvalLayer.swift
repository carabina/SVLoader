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
        fillColor = UIColor.whiteColor().CGColor
        centralPoint = center
        path = ovalPath.CGPath
    }
    
    var ovalPath: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: centralPoint.x, y: centralPoint.y, width: 8, height: 8))
    }
    
    var expandedOvalPath: UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(x: centralPoint.x - 2, y: centralPoint.y - 2, width: 12, height: 12))
    }
    
    func startAnimatingInA(seconds: CFTimeInterval) {
        let expandAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = ovalPath.CGPath
        expandAnimation.toValue = expandedOvalPath.CGPath
        expandAnimation.beginTime = seconds
        expandAnimation.duration = 0.2
        
        let shrinkAnimation = CABasicAnimation(keyPath: "path")
        shrinkAnimation.fromValue = expandedOvalPath.CGPath
        shrinkAnimation.toValue = ovalPath.CGPath
        shrinkAnimation.beginTime = expandAnimation.duration + expandAnimation.beginTime
        shrinkAnimation.duration = 0.2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [expandAnimation, shrinkAnimation]
        animationGroup.duration = expandAnimation.beginTime + shrinkAnimation.duration + shrinkAnimation.duration
        animationGroup.fillMode = kCAFillModeForwards
        addAnimation(animationGroup, forKey: nil)
    }
}
