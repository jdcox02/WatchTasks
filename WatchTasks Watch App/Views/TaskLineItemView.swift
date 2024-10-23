
//
//  TaskLineItemView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/14/24.
//

import SwiftUI

// A view that displays a single task as a line item, showing its title
// and indicating whether it's completed with a checkmark icon.
struct TaskLineItemView: View {
    var task: Task
    var body: some View {
        HStack {
            Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
            Text(task.title)
                .strikethrough(task.isComplete)
        }
        
    }
}

//#Preview {
//
//    let taskListModel = TaskListModel()
//    return TaskLineItemView(task: .constant(taskListModel.tasks[0]))
//        .environmentObject(taskListModel)
//}
