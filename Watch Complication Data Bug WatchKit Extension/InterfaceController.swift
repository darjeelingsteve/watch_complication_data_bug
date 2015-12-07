//
//  InterfaceController.swift
//  Watch Complication Data Bug WatchKit Extension
//
//  Created by Stephen Anthony on 07/12/2015.
//  Copyright © 2015 Darjeeling Apps. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBAction func incrementButtonTapped() {
        guard let extensionDelegate = WKExtension.sharedExtension().delegate as? ExtensionDelegate else {
            return
        }
        
        extensionDelegate.sendIncrementMessage()
    }
}
