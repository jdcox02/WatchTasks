
//
//  AddTaskView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/14/24.
//

import SwiftUI
import WidgetKit


// View for adding a new task in the DailyTasks Watch App.
// Users can input a brief description, optional notes, and mark the task as complete or not.
struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    var dataManager = DataManager.shared
    
    @State private var description = ""
    @State private var notes = ""
    @State private var isComplete = false
    
    var body: some View {
        Form {
        // Section for the user to enter a brief description of the task.
        Section(header: Text("Task:")) {
            TextField("Brief Description", text: $description)
        }
        // Section for the user to add optional notes related to the task.
        Section(header: Text("Task Notes: ")) {
              TextField("Notes", text: $notes)
          }
        // Section with a toggle for marking the task as complete or incomplete.
        Section(header: Text("Status")) {
              Toggle("Completed", isOn: $isComplete)
          }
        // Section containing a button to save the task.
        Section {
              Button("Done") {
                  // Creates a new task with the provided details.
                  let newTask = Task(title: description, notes: notes, creationDate: Date(), isComplete: isComplete)
                  
                  // Adds the new task using the DataManager.
                  dataManager.addTask(newTask)
                  
                  // Reloads the widget timeline to reflect the new task data.
                  WidgetCenter.shared.reloadTimelines(ofKind: "com.exampleteam.WatchTasks.complication")
                  
                  print("New task added: \(newTask)")
                  
                  // Dismisses the view after saving the task.
                  presentationMode.wrappedValue.dismiss()
              }
              .frame(maxWidth: .infinity, alignment: .center)
              .foregroundColor(.green)
          }
        }
    }
}
#Preview {
    AddTaskView()
}
