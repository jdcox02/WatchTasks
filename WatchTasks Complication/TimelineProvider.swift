
//
//  TimelineProvider.swift
//  DailyTasksComplicationExtension
//
//  Created by Joshua Cox on 4/21/24.
//

import Foundation
import WidgetKit
import SwiftData

struct Provider: TimelineProvider {
    let dataManager = DataManager.shared
    
    //Shown for first time (i.e. placeholder)
    @MainActor func placeholder(in context: Context) -> TaskProgressEntry {
        let entryDate = Date() // Define entryDate
        return TaskProgressEntry(date: entryDate, remainingTasks: 3)
    }
    
    //Shown in transient situations - dummy data
    @MainActor func getSnapshot(in context: Context, completion: @escaping (TaskProgressEntry) -> ()) {
        let entryDate = Date() // Define entryDate
        let entry = TaskProgressEntry(date: entryDate, remainingTasks: 3)
        completion(entry)
    }
    
    //Provided at regular intervals
    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<TaskProgressEntry>) -> ()) {
        var entries: [TaskProgressEntry] = []
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            
            
            let entry = TaskProgressEntry(date: entryDate, remainingTasks: dataManager.getRemainingTasksCount())
            print("REMAINING TASKS: \(dataManager.getRemainingTasksCount())")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
    

struct TaskProgressEntry: TimelineEntry {
    let date: Date
    let remainingTasks: Int
}
