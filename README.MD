# WatchTasks

**WatchTasks** is a SwiftUI-based app designed for watchOS, allowing users to manage their daily tasks, track progress over time, and receive timely notifications as reminders. The app leverages SwiftData, UserNotifications, and the SwiftUI framework to provide an efficient and user-friendly experience directly on the Apple Watch.

## Features

- **Task Management**: Add, edit, and delete tasks directly on your Apple Watch.
- **Task Progress Tracking**: Visualize your progress with a chart showing completed vs. remaining tasks over time.
- **Notifications**: Set custom reminders to help you stay on top of your daily tasks.
- **Persistent Data**: Automatically saves tasks and task history using SwiftData and UserDefaults.
- **Background Refresh**: Automatically resets daily tasks at midnight, keeping your list up-to-date each day.

## Installation

1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/yourusername/DailyTasksWatchApp.git
    ```
2. Open the project in Xcode:
    ```bash
    cd DailyTasksWatchApp
    open DailyTasksWatchApp.xcodeproj
    ```
3. Build and run the app on an Apple Watch simulator or your paired Apple Watch.

## Structure

The project follows an MVC-like structure, with components organized into Models, Views, and Controllers:

### Models

- **DataManager.swift**: Manages data storage and retrieval for `Task` and `TaskHistory`. This is the central point for interacting with data, including adding, removing, and resetting tasks.
- **Task.swift**: Defines the `Task` model, representing a single task with properties like `title`, `notes`, `creationDate`, and `isComplete`.
- **TaskHistory.swift**: Represents the history of tasks completed on a specific date, used for progress tracking.

### Views

- **ContentView.swift**: The main entry point for the app’s UI, providing a `TabView` to navigate between different sections of the app.
- **DailyTasksView.swift**: Displays a list of tasks and allows users to add, edit, or delete tasks.
- **DetailView.swift**: Shows the details of a selected task, with options to edit the task’s title, notes, and completion status.
- **AddTaskView.swift**: Allows users to create new tasks with a title, notes, and an initial completion status.
- **ProgressView.swift**: Displays a chart of task completion history, showing the number of completed and remaining tasks over the last few days.
- **AddNotificationView.swift**: Provides an interface for users to select a time for daily notifications.
- **ShareView.swift**: Allows users to share the status of a specific task.

### Controllers

- **WatchTasks_Watch_AppApp.swift**: The entry point for the watchOS app, responsible for setting up the main UI, background tasks, and managing the app’s lifecycle.
- **ApplicationDelegate.swift**: Manages application-level events such as background refresh and notification registration. It also schedules background tasks for resetting tasks at midnight.
- **NotificationMainView.swift**: Manages notification settings, allowing users to enable or disable reminders and adjust the time for daily notifications.

## How It Works

### Task Management

- Users can view their tasks in `DailyTasksView` and tap on any task to view or edit its details in `DetailView`.
- The `AddTaskView` is accessible from the main list to create new tasks with a title, optional notes, and a completion status.
- Tasks are stored persistently using SwiftData, ensuring they are available even after restarting the app.

### Progress Tracking

- The `ProgressView` uses the task history to display a bar chart of completed and remaining tasks for the last five days.
- The `TaskHistory` model records the number of completed and total tasks each day, enabling users to visualize their progress.

### Notifications

- Users can enable or disable notifications using a toggle in `NotificationMainView`.
- The `AddNotificationView` allows users to select a specific time to receive daily task reminders.
- Notifications are managed through the `UNUserNotificationCenter` and scheduled using the background task functionality in `WatchTasks_Watch_AppApp.swift`.

### Background Tasks

- The app automatically resets tasks at midnight using background refresh tasks, ensuring users start each day with a fresh task list.
- The `ApplicationDelegate` handles the scheduling of these background tasks and ensures that the app's data is updated correctly.

### Testing Watch Complications

- To test the watch complication (`com.joshuacox.WatchTasks.watchkitapp.WatchTasks-Complication`), you need to create a custom watch face on your Apple Watch or in the simulator that includes the complication.
- Once the watch face is set up with the complication, you will be able to see how the complication displays information and updates based on your tasks.

## Usage

1. **Add a Task**: Tap the "Add" button in the `DailyTasksView` to create a new task with a description and optional notes.
2. **Edit a Task**: Tap on a task in the list to view its details and make any changes, such as marking it as complete.
3. **Track Your Progress**: Navigate to the `ProgressView` to see your task completion over the past few days.
4. **Set a Reminder**: Go to the `NotificationMainView` to enable notifications and set a time for daily reminders.
5. **Share Task Status**: Use the `ShareView` to share the status of any task with others.

## Requirements

- Xcode 15 or later
- watchOS 10.0 or later
- Swift 5.9 or later

## Acknowledgements

- Built with SwiftUI and SwiftData.
- Uses the `Charts` framework for displaying task progress.
- Supports local notifications using `UserNotifications`.

## Contact

For questions or feedback, please reach out to:

- **Name**: Josh Cox
- **Email**: [jdcox02@gmail.com](mailto:jdcox02@gmail.com)
- **GitHub**: [jdcox02](https://github.com/jdcox02)
- **LinkedIn**: [jdcox02](https://www.linkedin.com/in/jdcox02)
