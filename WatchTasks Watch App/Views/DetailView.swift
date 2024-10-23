//
//  DetailView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/14/24.
//

import SwiftUI
import SwiftData
import WidgetKit

// Displays the details of a specific task, allowing users to view and edit task information.
struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    var dataManager = DataManager.shared
    var task: Task
    @State var title: String = ""
    @State var notes: String?
    @State var creationDate: Date = Date()
    @State var isComplete: Bool = false

    // Formats the date to display in "medium" style, showing only the date without time.
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    var body: some View {
        NavigationView {
            VStack {
                // Displays a form for editing the task details.
                Form {
                    // Section for editing the task's title.
                    Section(header: Text("Task: ")) {
                        TextField("Brief Description", text: $title)
                    }
                    // Section for editing the task's notes.
                    Section(header: Text("Task Notes: ")){
                        TextField("Notes", text: Binding(
                            get: { notes ?? "" },
                            set: { notes = $0 }
                        ))
                    }
                    // Section showing the creation date of the task (read-only).
                    Section(header: Text("Created on: ")) {
                        Text(dateFormatter.string(from: creationDate))
                    }
                    // Section for toggling the task's completion status.
                    Section(header: Text("Status: ")) {
                        Toggle(isOn: $isComplete) {
                            Text("Completed")
                        }
                    }
                    
                    Section {
                        // Section for sharing the task using a custom ShareView.
                        ShareView(task: task)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.blue)
                    }
                    
                    // Section for deleting the task.
                    Section {
                        Button {
                            dataManager.removeTask(task)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Delete Task")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // Adds a 'Cancel' button to the top-left, dismissing the view without saving.
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                // Adds a 'Done' button to the top-right, saving any changes and dismissing the view.
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        updateTask()
                        WidgetCenter.shared.reloadTimelines(ofKind: "com.exampleteam.WatchTasks.complication")
                        dismiss()
                    }
                }
            }
            
        }
        .onAppear {
            // Sets initial values when the view appears, so it matches the task's existing data.
            title = task.title
            notes = task.notes
            isComplete = task.isComplete
        }

    }
        
    // Updates the task with the new values entered by the user.
    func updateTask() {
        task.title = title
        task.notes = notes
        task.isComplete = isComplete
    }
    

}
    
//
//#Preview {
//    var task = Task(title: "Run 100 miles", creationDate: Date(), isComplete: false)
//    return DetailView(task: task)
//
//}
