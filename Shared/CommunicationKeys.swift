//
//  CommunicationKeys.swift
//  Watch Complication Data Bug
//
//  Created by Stephen Anthony on 07/12/2015.
//  Copyright © 2015 Darjeeling Apps. All rights reserved.
//

import Foundation

/*
The key to use when sending an action message from Apple Watch to the iPhone.
*/
let ActionKey = "ActionKey"

/*
The action to send keyed by `ActionKey` when requesting that the current counter
be incremented on the iPhone.
*/
let IncrementAction = "IncrementAction"

/*
The key to use when transfering the current counter value from the iPhone to the
paired Apple Watch.
*/
let CounterUserInfoKey = "CounterUserInfoKey"