//
//  ProgressView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/21/24.
//

import SwiftUI
import Charts
import SwiftData

// Displays a progress chart for the user's task completion history,
// showing how many tasks were completed vs. remaining over the last few days.
struct ProgressView: View {
    // Fetches task history data, sorted by date in descending order (most recent first).
    @Query(sort: \TaskHistory.date, order: .reverse)  var taskHistory: [TaskHistory]
    // Date formatter for displaying dates in "M/d" format on the chart's x-axis.
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter
    }()

    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                // Show a message if there is no task history available.
                if taskHistory.isEmpty {
                    Text("Task history unavailable.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Display the last 5 entries of the task history, reversed for chronological order.
                    let displayedTasks = Array(taskHistory.prefix(5).reversed())
                    Chart {
                        ForEach(displayedTasks, id: \.id) { history in
                            // Bar for completed tasks
                            BarMark(
                                x: .value("Date", dateFormatter.string(from: history.date)),
                                y: .value("Completed", history.completedTasks)
                            )
                            .foregroundStyle(.blue)

                            // Bar for remaining tasks
                            BarMark(
                                x: .value("Date", dateFormatter.string(from: history.date)),
                                y: .value("Remaining", history.totalTasks - history.completedTasks)
                            )
                            .foregroundStyle(.gray)
                        }
                    }
                    .chartXAxis {
                        AxisMarks(preset: .aligned, position: .bottom) {
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel()
                        }
                    }
                    .chartYAxis {
                        AxisMarks(preset: .aligned, position: .leading) {
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel()
                        }
                    }
                    .chartForegroundStyleScale([
                        "Completed": .blue, "Remaining": .gray
                    ])
                    .padding(.horizontal)
                }
                Spacer()
            }
            .navigationTitle("Tasks Progress")
        }
    }
}

//struct ProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        let dummyData = [
//            TaskHistoryMarker(date: formatter.date(from: "04/18/2024")!, completedTasks: 6, totalTasks: 8),
//            TaskHistoryMarker(date: formatter.date(from: "04/19/2024")!, completedTasks: 3, totalTasks: 8),
//            TaskHistoryMarker(date: formatter.date(from: "04/20/2024")!, completedTasks: 8, totalTasks: 8),
//            TaskHistoryMarker(date: formatter.date(from: "04/21/2024")!, completedTasks: 2, totalTasks: 8),
//            TaskHistoryMarker(date: formatter.date(from: "04/22/2024")!, completedTasks: 7, totalTasks: 8)
//        ]
//        return ProgressView(taskHistory: dummyData)
//    }
//}
