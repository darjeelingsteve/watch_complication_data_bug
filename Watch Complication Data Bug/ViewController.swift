//
//  ViewController.swift
//  Watch Complication Data Bug
//
//  Created by Stephen Anthony on 07/12/2015.
//  Copyright © 2015 Darjeeling Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCounterLabel()
        NSNotificationCenter.defaultCenter().addObserverForName(CounterValueDidChangeNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (_) -> Void in
            self.configureCounterLabel()
        }
    }
    
    func configureCounterLabel() {
        counterLabel.text = String(Counter.sharedCounter.value)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

