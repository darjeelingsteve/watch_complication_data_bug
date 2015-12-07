//
//  AppDelegate.swift
//  Watch Complication Data Bug
//
//  Created by Stephen Anthony on 07/12/2015.
//  Copyright © 2015 Darjeeling Apps. All rights reserved.
//

import UIKit
import WatchConnectivity

let ComplicationDataBugCounterDefaultsKey = "ComplicationDataBugCounterDefaultsKey"
let AppDelegateDidUpdateCounterNotification = "AppDelegateDidUpdateCounterNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
    var window: UIWindow?
    let session = WCSession.defaultSession()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        session.delegate = self
        session.activateSession()
        return true
    }
    
    //MARK: WCSessionDelegate
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        guard let action = message[ActionKey] as? String where action == IncrementAction else {
            return
        }
        
        // Increment the current count
        var counter = NSUserDefaults.standardUserDefaults().integerForKey(ComplicationDataBugCounterDefaultsKey)
        ++counter
        NSUserDefaults.standardUserDefaults().setInteger(counter, forKey: ComplicationDataBugCounterDefaultsKey)
        NSNotificationCenter.defaultCenter().postNotificationName(AppDelegateDidUpdateCounterNotification, object: self)
        
        // Send updated complication data
        self.session.transferCurrentComplicationUserInfo([CounterUserInfoKey : counter])
    }
    
    func session(session: WCSession, didFinishUserInfoTransfer userInfoTransfer: WCSessionUserInfoTransfer, error: NSError?) {
        print(__FUNCTION__)
        print("Transfer: \(userInfoTransfer)")
        print("Error: \(error)")
    }
    
    func sessionReachabilityDidChange(session: WCSession) {
        print(__FUNCTION__)
        print(session.reachable ? "Reachable" : "Not reachable")
    }
}

