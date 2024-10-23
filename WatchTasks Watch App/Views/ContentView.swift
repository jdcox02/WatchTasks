//
//  ContentView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/14/24.
//

import SwiftUI
import SwiftData

// The main content view that serves as the entry point for the DailyTasks Watch App.
// Displays a tab-based navigation structure for switching between different app views.
struct ContentView: View {
    var body: some View {
        VStack {
            TabView() {
                DailyTasksView()
                ProgressView()
                NotificationMainView()
            }
        }
    }
}



//#Preview {
//    let taskListModel = TaskListModel()
//
//    return ContentView()
//        .modelContainer(for: Task.self, inMemory: true)
//}
