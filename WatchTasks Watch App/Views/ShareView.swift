//
//  ShareView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/15/24.
//

import SwiftUI

// A view that allows sharing the status of a task as a text message.
struct ShareView: View {
    var task: Task
    var body: some View {
        // Creates a shareable link with the task's title and its completion status.
        ShareLink("Share", item: "Task: \(task.title) is \(task.isComplete ? "complete": "incomplete").")
    }
}

#Preview {
    let todayDate = Date()
    let task = Task(title: "Run 100 miles", creationDate: todayDate, isComplete: false)
    return ShareView(task: task)
}
