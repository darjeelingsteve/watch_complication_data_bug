//
//  ComplicationController.swift
//  Watch Complication Data Bug WatchKit Extension
//
//  Created by Stephen Anthony on 07/12/2015.
//  Copyright © 2015 Darjeeling Apps. All rights reserved.
//

import ClockKit

/// The user defaults key used to store the current counter value.
private let ComplicationControllerCounterDefaultsKey = "ComplicationControllerCounterDefaultsKey"

/// The object responsible for providing complication data.
class ComplicationController: NSObject, CLKComplicationDataSource {
    class var counterValue: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(ComplicationControllerCounterDefaultsKey)
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: ComplicationControllerCounterDefaultsKey)
        }
    }
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.None])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate())
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate())
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        let template = templateForComplication(complication, counter: ComplicationController.counterValue)
        let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
        handler(timelineEntry)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(templateForComplication(complication, counter: nil))
    }
    
    private func templateForComplication(complication: CLKComplication, counter: Int?) -> CLKComplicationTemplate {
        let complicationTemplate: CLKComplicationTemplate
        
        switch complication.family {
        case .ModularSmall:
            let template = CLKComplicationTemplateModularSmallSimpleText()
            template.textProvider = textProviderWithNumber(counter)
            complicationTemplate = template
        case .ModularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "Counter")
            template.bodyTextProvider = textProviderWithNumber(counter)
            complicationTemplate = template
        case .UtilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = textProviderWithNumber(counter)
            complicationTemplate = template
        case .UtilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = textProviderWithNumber(counter)
            complicationTemplate = template
        case .CircularSmall:
            let template = CLKComplicationTemplateCircularSmallSimpleText()
            template.textProvider = textProviderWithNumber(counter)
            complicationTemplate = template
        }
        return complicationTemplate
    }
    
    private func textProviderWithNumber(number: Int?) -> CLKTextProvider {
        return CLKSimpleTextProvider(text: (number != nil) ? String(number!) : "--")
    }
}
