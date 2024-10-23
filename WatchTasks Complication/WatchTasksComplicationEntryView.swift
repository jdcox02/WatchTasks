//
//  WatchTasksComplicationEntryView.swift
//  WatchTasks ComplicationExtension
//
//  Created by Joshua Cox on 4/26/24.
//

import SwiftUI
import WidgetKit

struct WatchTasksComplicationEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        TaskView(remainingTasks: entry.remainingTasks)
    }
    
}
    
#Preview(as: .accessoryRectangular) {
    WatchTasksComplication()
} timeline: {
    TaskProgressEntry(date: .now, remainingTasks: 3)
    TaskProgressEntry(date: .now, remainingTasks: 1)
}
