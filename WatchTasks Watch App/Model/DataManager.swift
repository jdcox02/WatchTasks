//
//  DataManager.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/26/24.
//

import Foundation
import SwiftData


// Handles all the data stuff for tasks and task history.
class DataManager {
    
    // Singleton pattern—makes sure we only have one instance of DataManager running around.
    static let shared = DataManager()
    var greeting = "Hello"
    
    // Sets up the storage for tasks and their history. We're using a schema to keep it all organized.
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
            TaskHistory.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        // Try to create the container and crash the app if it fails—can't do much without this.
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // Resets the day's task data—deletes history markers and marks all tasks as incomplete.
    @MainActor
    func resetDay() {
        deleteAllTaskHistoryMarkers()
        print("🏃 the background task is running!!!!")
        print("Before Dump:")
        dumpTasks()
        print(getRemainingTasksCount())
        
        // Iterate over all tasks and mark them as not complete
        print("Resetting all tasks...")
        
        let taskDescriptor = FetchDescriptor<Task>()
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            let completedTasks = getCompletedTasksCount()
            let totalTasks = getTasksCount()
                
            print("Number of total tasks: \(totalTasks)")
            print("Number of completed tasks: \(completedTasks)")
            
            // Adds a new marker for today’s progress before resetting
            let newTaskHistoryMarker = TaskHistory(date: Date(), completedTasks: completedTasks, totalTasks: totalTasks)
            addTaskHistoryMarker(newTaskHistoryMarker)
            
            fetchedTasks.forEach { task in
                task.isComplete = false
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        print("After Dump:")
        dumpTasks()
        
        print("Task History")
        dumpTaskHistoryMarkers()
        
        print("🏃 the background task ran!!!!")
    }
    
    
    // Marks all tasks as completed for testing or resetting purposes.
    @MainActor
    func resetTasks() {
        
        // Loop through all tasks and mark them as complete.
        print("🏃 the background task is running!!!!")
        print("Before Dump:")
        dumpTasks()
        
        // This will go through and mark all tasks as completed
        print("Completing all tasks...")
        
        let taskDescriptor = FetchDescriptor<Task>()
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            fetchedTasks.forEach { task in
                task.isComplete = true
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        print("After Dump:")
        dumpTasks()
        
        print("Task History")
        dumpTaskHistoryMarkers()
        let th = TaskHistory(date: Date.now, completedTasks: 2, totalTasks: 3)
        addTaskHistoryMarker(th)
        print("Added new history")
        dumpTaskHistoryMarkers()
        print("🏃 the background task ran!!!!")
        
        let totalTasks = getTasksCount()
        let completedTasks = getCompletedTasksCount()
            
        print("Number of total tasks: \(totalTasks)")
        print("Number of completed tasks: \(completedTasks)")
        
        let newTaskHistoryMarker = TaskHistory(date: Date(), completedTasks: completedTasks, totalTasks: totalTasks)
        addTaskHistoryMarker(newTaskHistoryMarker)
    }
    
    // Adds a new task to the model.
    @MainActor
    func addTask(_ task: Task) {
        sharedModelContainer.mainContext.insert(task)
    }
    
    // Adds a new task history marker to track progress.
    @MainActor
    func addTaskHistoryMarker(_ taskHistoryMarker: TaskHistory) {
        sharedModelContainer.mainContext.insert(taskHistoryMarker)
    }
    
    // Removes a task from the model.
    @MainActor
    func removeTask(_ task: Task) {
        sharedModelContainer.mainContext.delete(task)
    }
    
    // Removes a task history marker from the model.
    @MainActor
    func removeTaskHistoryMarker(_ taskHistoryMarker: TaskHistory) {
        sharedModelContainer.mainContext.delete(taskHistoryMarker)
    }
    

    // Prints all tasks to the console for debugging.
    @MainActor
    func dumpTasks() {
        print("Dumping all tasks...")
        let taskDescriptor = FetchDescriptor<Task>(
            sortBy: [
                .init(\.creationDate)
            ]
        )
        
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            fetchedTasks.forEach { task in
                print("✅ Task - Id:\(task.id) Date:\(task.creationDate) Complete:\(task.isComplete) \(task.title)")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // Prints all task history markers to the console for debugging.
    @MainActor
    func dumpTaskHistoryMarkers() {
        print("Dumping all task history markers...")
        let taskDescriptor = FetchDescriptor<TaskHistory>(
            sortBy: [
                .init(\.date)
            ]
        )
        
        do {
            let fetchedHistory = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            fetchedHistory.forEach { history in
                print("✅ TaskHistoryMarker - Id:\(history.id) Date:\(history.date) Number of completed tasks:\(history.completedTasks) Number of total tasks:\(history.totalTasks)")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // Fetches all tasks from storage.
    @MainActor
    func getAllTasks() -> [Task] {
        print("Retrieving all tasks...")
        let taskDescriptor = FetchDescriptor<Task>(
            sortBy: [
                .init(\.creationDate)
            ]
        )
        
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            return fetchedTasks
            
        } catch {
            // Return an empty array if there is an error
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    // Returns the total number of tasks.
    @MainActor
    func getTasksCount() -> Int {
        print("Counting number of tasks...")
        let taskDescriptor = FetchDescriptor<Task>(
            sortBy: [
                .init(\.creationDate)
            ]
        )
        
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            return fetchedTasks.count
        } catch {
            // Return 0 there is an error
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    // Counts how many tasks are marked as complete.
    @MainActor
    func getCompletedTasksCount() -> Int {
        print("Counting number of tasks...")
        let taskDescriptor = FetchDescriptor<Task>(
            sortBy: [
                .init(\.creationDate)
            ]
        )
        
        var completed_tasks_count = 0
        
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            
            fetchedTasks.forEach { task in
                if task.isComplete {
                    completed_tasks_count += 1
                }
            }
            
            return completed_tasks_count
            
        } catch {
            // Return 0 there is an error
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    // Counts how many tasks are still not done.
    @MainActor
    func getRemainingTasksCount() -> Int {
        print("Counting number of remaining tasks...")
        let taskDescriptor = FetchDescriptor<Task>(
            sortBy: [
                .init(\.creationDate)
            ]
        )
        
        var remainingTasksCount = 0
        
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            
            fetchedTasks.forEach { task in
                if !task.isComplete {
                    remainingTasksCount += 1
                }
            }
            
            return remainingTasksCount
            
        } catch {
            // Return 0 if there is an error
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    // Fetches all task history markers from storage.
    @MainActor
    func getAllTaskHistoryMarkers() -> [TaskHistory] {
        print("Retrieving all tasks...")
        let taskDescriptor = FetchDescriptor<TaskHistory>(
            sortBy: [
                .init(\.date)
            ]
        )
        
        do {
            let fetchedHistory = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            return fetchedHistory
            
        } catch {
            // Return an empty array if there is an error
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    // Deletes all tasks—good for when you need a clean slate.
    @MainActor
    func deleteAllTasks() {
        print("Deleting all tasks...")
        let taskDescriptor = FetchDescriptor<Task>()
        
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            fetchedTasks.forEach { task in
                sharedModelContainer.mainContext.delete(task)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
        
    // Deletes all task history markers from storage
    @MainActor
    func deleteAllTaskHistoryMarkers() {
        print("Deleting all task history markers...")
        let taskDescriptor = FetchDescriptor<TaskHistory>()
        
        do {
            let fetchedHistory = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            fetchedHistory.forEach { history in
                sharedModelContainer.mainContext.delete(history)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
      
    
    // Marks every task as complete—useful for testing or if you need a way to quickly
    // set all tasks to a completed state.
    @MainActor
    func completeAllTasks() {
        print("Completing all tasks...")
        let taskDescriptor = FetchDescriptor<Task>()
        do {
            let fetchedTasks = try sharedModelContainer.mainContext.fetch(taskDescriptor)
            fetchedTasks.forEach { task in
                task.isComplete = true
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
