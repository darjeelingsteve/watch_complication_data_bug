//
//  Counter.swift
//  Watch Complication Data Bug
//
//  Created by Stephen Anthony on 09/12/2015.
//  Copyright © 2015 Darjeeling Apps. All rights reserved.
//

import Foundation

/// The notification posted when the counter value changes.
let CounterValueDidChangeNotification = "CounterValueDidChangeNotification"

/// The user defaults key used to store the current counter value.
private let CounterValueDefaultsKey = "CounterValueDefaultsKey"

/// The class responsible for managing the counter value.
class Counter: NSObject {
    static let sharedCounter = Counter()
    
    var value: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(CounterValueDefaultsKey)
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: CounterValueDefaultsKey)
            NSNotificationCenter.defaultCenter().postNotificationName(CounterValueDidChangeNotification, object: self)
        }
    }
    
    func increment() {
        value = value + 1
    }
}
