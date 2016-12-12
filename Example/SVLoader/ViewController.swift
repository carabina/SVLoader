//
//  ViewController.swift
//  SVLoader
//
//  Created by Slava Semeniuk on 12/12/2016.
//  Copyright (c) 2016 Slava Semeniuk. All rights reserved.
//

import UIKit
import SVLoader

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SVLoader.set(UIFont(name: "HelveticaNeue", size: 15)!)
    }
    
    @IBAction func startLoadingoTouched(sender: AnyObject) {
        SVLoader.showLoaderWith("Loading...")
        NSTimer.scheduledTimerWithTimeInterval(4.2, target: self, selector: #selector(hideLoader),
                                               userInfo: nil, repeats: false)
    }
    
    func hideLoader() {
        SVLoader.hideLoaderWith(completion: nil)
    }
    
}

