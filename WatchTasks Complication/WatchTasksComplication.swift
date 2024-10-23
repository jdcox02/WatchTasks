//
//  WatchTasksComplication.swift
//  WatchTasks Watch App
//
//  Created by Joshua Cox on 4/26/24.


import WidgetKit
import SwiftUI

@main
struct WatchTasksComplication: Widget {
    let kind: String = "com.exampleteam.WatchTasks.complication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(watchOS 10.0, *) {
                WatchTasksComplicationEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WatchTasksComplicationEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Watch Tasks")
        .description("Show progress on your daily tasks")
        .supportedFamilies([.accessoryRectangular])
    }
}
