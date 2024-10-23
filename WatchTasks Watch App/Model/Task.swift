//
//  Task.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/14/24.
//

import Foundation
import SwiftData


// Represents a Task model that can be stored and managed within the app.
// Each task has a unique ID, a title, optional notes, a creation date, and a completion status.
@Model
class Task {
    let id: UUID
    var title: String
    var notes: String?
    var creationDate: Date
    var isComplete: Bool
    
    init(title: String, notes: String? = nil, creationDate: Date, isComplete: Bool) {
        self.id = UUID()
        self.title = title
        self.notes = notes
        self.creationDate = creationDate
        self.isComplete = isComplete
    }
}
