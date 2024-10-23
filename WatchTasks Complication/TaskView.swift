
//
//  TaskView.swift
//  DailyTasksComplicationExtension
//
//  Created by Joshua Cox on 4/23/24.
//

import SwiftUI
import WidgetKit

struct TaskView: View {
    let remainingTasks: Int
    
    var body: some View {
        VStack {
            Text("\(remainingTasks) remaining \(remainingTasks == 1 ? "task" : "tasks")")
                .font(.headline)
                .widgetAccentable()
        }
    }
    
//    private var completionPercentage: Double {
//        guard totalTasks > 0 else { return 0 }
//        return Double(completedTasks) / Double(totalTasks)
//    }
}
//
//#Preview {
//    return TaskView(completedTasks: 5, totalTasks: 10)
//}
