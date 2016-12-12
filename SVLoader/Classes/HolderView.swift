//
//  HolderView.swift
//  Loader
//
//  Created by Slava Semeniuk on 12/12/16.
//  Copyright © 2016 Slava Semeniuk. All rights reserved.
//

import UIKit

class HolderView: UIView {

    var leftOvalLayer: OvalLayer!
    var rigthOvalLayer: OvalLayer!
    var centralOvalLayer: OvalLayer!
    var rectLayer: CALayer!
    var shouldAnimate = false
    var label: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        addRectLayer()
        addOvalLayers()
        addLabel()
    }
    
    private func addOvalLayers() {
        centralOvalLayer = OvalLayer(center: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2 + 15))
        leftOvalLayer = OvalLayer(center: CGPoint(x: bounds.size.width / 2 - 20, y: bounds.size.height / 2 + 15))
        rigthOvalLayer = OvalLayer(center: CGPoint(x: bounds.size.width / 2 + 20, y: bounds.size.height / 2 + 15))
        layer.addSublayer(leftOvalLayer)
        layer.addSublayer(centralOvalLayer)
        layer.addSublayer(rigthOvalLayer)
    }
    
    private func addRectLayer() {
        rectLayer = CALayer()
        rectLayer.backgroundColor = UIColor.blackColor().CGColor
        rectLayer.shadowOffset = CGSize(width: 0, height: 3)
        rectLayer.shadowColor = UIColor.blackColor().CGColor
        rectLayer.shadowRadius = 5
        let width: CGFloat = 200
        let height: CGFloat = 120
        rectLayer.frame = CGRect(x: (bounds.size.width - width) / 2, y: (bounds.size.height - height) / 2, width: width, height: height)
        rectLayer.cornerRadius = 8
        layer.addSublayer(rectLayer)
    }
    
    private func addLabel() {
        let labelFrame = CGRect(x: rectLayer.frame.origin.x + 10, y: bounds.size.height / 2 - 30, width: rectLayer.frame.size.width - 15, height: 30)
        label = UILabel(frame: labelFrame)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        addSubview(label)
    }
    
    func showWith(message: String) {
        label.text = message
        animate()
    }

    @objc private func animate() {
        if !shouldAnimate {
           return
        }
        leftOvalLayer.startAnimatingInA(0)
        centralOvalLayer.startAnimatingInA(0.4)
        rigthOvalLayer.startAnimatingInA(0.8)
        NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: #selector(animate),
                             userInfo: nil, repeats: false)
    }
}
