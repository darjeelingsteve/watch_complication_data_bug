//
//  ExtensionDelegate.swift
//  Watch Complication Data Bug WatchKit Extension
//
//  Created by Stephen Anthony on 07/12/2015.
//  Copyright © 2015 Darjeeling Apps. All rights reserved.
//

import WatchKit
import WatchConnectivity
import ClockKit

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
    let session = WCSession.defaultSession()
    
    func applicationDidFinishLaunching() {
        session.delegate = self
        session.activateSession()
    }
    
    func sendIncrementMessage() {
        session.sendMessage([ActionKey : IncrementAction], replyHandler: nil, errorHandler: nil)
    }
    
    //MARK WCSessionDelegate
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        guard let counter = userInfo[CounterUserInfoKey] as? Int else {
            // Invalid payload
            return
        }
        
        ComplicationController.counterValue = counter
        
        // Update the user's complications.
        let complicationServer = CLKComplicationServer.sharedInstance()
        for complication in complicationServer.activeComplications {
            complicationServer.reloadTimelineForComplication(complication)
        }
    }
}
