//
//  DailyTasksView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/14/24.
//

import SwiftUI
import SwiftData

// Displays a list of daily tasks, allowing users to navigate to task details or add new tasks.
struct DailyTasksView: View {
    @Query var tasks: [Task] // Retrieves the list of tasks from the model.
    @State var isAddTaskViewPresented: Bool = false // Controls whether the AddTaskView is shown.
    var body: some View {
        NavigationStack {
            // List of tasks with navigation links to their detail views.
            List {
                ForEach(tasks) { task in
                    // Navigation link to the DetailView of the selected task.
                    NavigationLink(destination: DetailView(task: task).navigationBarBackButtonHidden(true)) {
                        TaskLineItemView(task: task) // Displays each task as a line item.
                    }
                }
                // Button to add a new task.
                Button(action: {
                    isAddTaskViewPresented = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
                    }
                    .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(8)

            }
            
            .navigationTitle("Daily Tasks")  // Sets the title of the navigation bar.
            .navigationBarBackButtonHidden(true) // Hides the default back button.
            .sheet(isPresented: $isAddTaskViewPresented) {
                AddTaskView()
            }
            
        }

        
    }
}

//#Preview {
//var tasks = [Task(title: "Finish the project report", creationDate: Date(), isComplete: false),
//             Task(title: "Meeting with the design team", creationDate: Date(), isComplete: true),
//        Task(title: "Grocery shopping", creationDate: Date(), isComplete: false),
//        Task(title: "Read the book on SwiftUI", creationDate: Date(), isComplete: false),
//        Task(title: "Weekly team sync", creationDate: Date(), isComplete: true)]
//
//return DailyTasksView(tasks: tasks)
//}
