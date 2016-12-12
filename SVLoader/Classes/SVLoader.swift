//
//  Loader.swift
//  Loader
//
//  Created by Slava Semeniuk on 12/12/16.
//  Copyright © 2016 Slava Semeniuk. All rights reserved.
//

import UIKit

public class SVLoader: NSObject {
    
    private static let sharedLoader = SVLoader()
    private var loaderWindow: UIWindow?
    private var holderView: HolderView!
    
    var animating = false {
        didSet {
            holderView.shouldAnimate = animating
        }
    }
    
    override init() {
        super.init()
        holderView = HolderView(frame: UIScreen.mainScreen().bounds)
    }
    
    private func showLoaderWindowWith(message: String) {
        if loaderWindow == nil {
            loaderWindow = UIWindow(frame: UIApplication.sharedApplication().keyWindow!.frame)
            let lastWindowLevel = UIApplication.sharedApplication().windows.last!.windowLevel
            loaderWindow!.windowLevel = lastWindowLevel + 1
            loaderWindow!.addSubview(holderView!)
            loaderWindow?.alpha = 0
        }
        loaderWindow!.makeKeyAndVisible()
        UIView.animateWithDuration(0.4, animations: {
            self.loaderWindow!.alpha = 1
        })
        holderView.showWith(message)
    }

    public class func showLoaderWith(message: String) {
        if sharedLoader.animating {
            return
        }
        sharedLoader.animating = true
        sharedLoader.showLoaderWindowWith(message)
    }
    
    public class func hideLoaderWithCompletion(completion: (() -> Void)? = nil) {
        if !sharedLoader.animating {
            return
        }
        sharedLoader.animating = false
        UIView.animateWithDuration(0.4, animations: {
            sharedLoader.loaderWindow?.alpha = 0
        }, completion: {
            if $0 {
                sharedLoader.loaderWindow?.resignKeyWindow()
                completion?()
            }
        })
        
    }
    
    public class func set(font: UIFont) {
        sharedLoader.holderView.label.font = font
    }
}
