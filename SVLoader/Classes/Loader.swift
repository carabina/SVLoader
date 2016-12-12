//
//  Loader.swift
//  Loader
//
//  Created by Slava Semeniuk on 12/12/16.
//  Copyright © 2016 Slava Semeniuk. All rights reserved.
//

import UIKit

class Loader: NSObject {
    
    private static let sharedLoader = Loader()
    private var loaderWindow: UIWindow?
    private var holderView: HolderView!
    var animating = false {
        didSet {
            holderView.shouldAnimate = animating
        }
    }
    
    override init() {
        super.init()
        holderView = HolderView(frame: UIScreen.main.bounds)
    }
    
    private func showOnLoaderWindow() {
        if loaderWindow == nil {
            loaderWindow = UIWindow(frame: UIApplication.shared.keyWindow!.frame)
            let lastWindowLevel = UIApplication.shared.windows.last!.windowLevel
            loaderWindow!.windowLevel = lastWindowLevel + 1
            loaderWindow!.addSubview(holderView!)
            loaderWindow?.alpha = 0
        }
        loaderWindow!.makeKeyAndVisible()
        UIView.animate(withDuration: 0.4, animations: {
            self.loaderWindow!.alpha = 1
        })
        holderView.showWith(message: "Hello")
    }

    class func showLoader() {
        if sharedLoader.animating {
            return
        }
        sharedLoader.animating = true
        sharedLoader.showOnLoaderWindow()
    }
    
    class func hideLoaderWith(completion block: (() -> Void)?) {
        if !sharedLoader.animating {
            return
        }
        sharedLoader.animating = false
        UIView.animate(withDuration: 0.4, animations: {
            sharedLoader.loaderWindow?.alpha = 0
        }, completion: {
            if $0 {
                sharedLoader.loaderWindow?.resignKey()
                block?()
            }
        })
        
    }
    
    
    class func set(font: UIFont) {
        sharedLoader.holderView.label.font = font
    }


}
