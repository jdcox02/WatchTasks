
//
//  TaskHistory.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/21/24.
//

import Foundation
import SwiftData

// Represents a TaskHistory model to store the history of tasks on a specific date.
// This keeps track of how many tasks were completed and the total number of tasks on a given day.
@Model
class TaskHistory {
    let id: UUID
    var date: Date
    var completedTasks: Int
    var totalTasks: Int
    
    init(date: Date, completedTasks: Int, totalTasks: Int){
        self.id = UUID()
        self.date = date
        self.completedTasks = completedTasks
        self.totalTasks = totalTasks
    }
    
    
}
