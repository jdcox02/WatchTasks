
//
//  ApplicationDelegate.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/20/24.
//

import Foundation
import WatchKit
import SwiftData
import ClockKit
import UserNotifications
import WidgetKit


// Manages the lifecycle of the Watch app and handles background tasks and notifications.
class ApplicationDelegate: NSObject, WKApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // Reference to the shared DataManager for managing tasks and their history.
    let dataManager = DataManager.shared
    
    func applicationDidFinishLaunching() {
        print("Did finish launching")
        
        // Store the current date as currentDate in user defaults.
        //This will be compared and updated each day using background tasks
        if UserDefaults.standard.object(forKey: "currentDate") == nil {
            let currentDate = Date()
            UserDefaults.standard.set(currentDate, forKey: "C")
            print("Current date stored: \(currentDate)")
        }
        
        // Request permission from the user to send notifications with alerts, sounds, and badges.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
        
        // Set this class as the delegate for handling notification interactions.
        UNUserNotificationCenter.current().delegate = self
    }
    
    // Called when the app enters the background.
    func applicationDidEnterBackground() {
        print("Did enter background")
        
        // Schedule a background refresh task to run while the app is in the background.
        scheduleBackgroundRefreshTask()
        
        // Reloads the timelines of any widgets to ensure they display the latest task data.
        WidgetCenter.shared.reloadTimelines(ofKind: "com.exampleteam.WatchTasks.complication")
        
    }
    
    func applicationWillEnterForeground() {
        print("Will enter foreground")
    }
    
    func applicationDidBecomeActive() {
        print("Did become active")
    }
    
    func applicationWillResignActive() {
        print("Will resign active")
    }
    
    func scheduleBackgroundRefreshTask() {
        print("Scheduling a background task")
        
        // Schedules a background task to run after a 15-second delay, using "MIDNIGHT_RESET" as user info.
        WKApplication.shared()
            .scheduleBackgroundRefresh(
                withPreferredDate: Date.init(timeIntervalSinceNow: 1.0 * 15.0),
                userInfo: "MIDNIGHT_RESET" as NSSecureCoding & NSObjectProtocol) { error in
                    if error != nil {
                        // Handle the scheduling error.
                        fatalError("*** An error occurred while scheduling the background refresh task. ***")
                    }
                    print("*** Scheduled! ***")
                }
        
    }
}

