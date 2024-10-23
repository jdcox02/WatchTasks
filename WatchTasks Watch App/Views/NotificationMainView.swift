
//
//  NotificationView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/23/24.
//

import SwiftUI
import WatchKit
import UserNotifications

struct NotificationMainView: View {
    @State var selectedHour: Int = 0 // Stores the selected hour for notification.
    @State var selectedMinute: Int = 0
    @State var notifyOn: Bool = false // Stores the selected minute for notification.
    @State var isAddNotificationViewPresented = false // Tracks if notifications are enabled or disabled.
    @State private var notificationTime: String? // Store the formatted notification time

    // Main view for managing notification settings, including enabling/disabling notifications
    // and scheduling or resetting notification times.
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    // Toggle to enable or disable notifications.
                    Toggle(isOn: $notifyOn) {
                        Text("Notifications")
                            .padding()
                    }
                    .padding(.horizontal) // Add padding to make the toggle area easier to tap
                    .frame(maxWidth: .infinity) // Expand the toggle area to fill the entire width
                    .onChange(of: notifyOn) {
                        var newValue = notifyOn
                        UserDefaults.standard.set(newValue, forKey: "notifyOn")
                        loadNotificationSettings()
                        if !newValue {
                            notificationTime = nil
                            cancelNotifications()
                        }
                    }
                    // Adjusts the layout if notifications are turned off.
                    if !notifyOn {Spacer()}
                }
                .onTapGesture {
                    notifyOn.toggle()
                }
                
                // Display current notification time or allow the user to add or reset it.
                if notifyOn {
                    if let time = notificationTime {
                        Spacer()
                        Text(
                            "Notifications scheduled for: \(time)"
                        )
                        // Button to reset the existing notification time.
                        Button(action: {
                            resetNotification()
                            isAddNotificationViewPresented.toggle()
                        }) {
                            Text("Reset")
                        }
                    }
                    else {
                        // Button to add a new notification time.
                        Button(action: {
                            isAddNotificationViewPresented.toggle()
                        }) {
                            Text(
                                "Add Notification"
                            )
                            .padding()
                            .background(
                                .green
                            )
                            .foregroundColor(
                                .white
                            )
                            .cornerRadius(
                                10
                            )
                        }
                        .animation(
                            .snappy,
                            value: notifyOn
                        )
                        .ignoresSafeArea()
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $isAddNotificationViewPresented, onDismiss: {
                loadNotificationSettings()
            }) {
                AddNotificationView()
            }
        }
        .onAppear() {
            loadNotificationSettings()
        }
    }
    
    
// Loads the notification settings from UserDefaults.
private func loadNotificationSettings() {
    if let notifyPreference = UserDefaults.standard.value(forKey: "notifyOn") as? Bool,
        let selectedHour = UserDefaults.standard.value(forKey: "selectedHour") as? Int,
        let selectedMinute = UserDefaults.standard.value(forKey: "selectedMinute") as? Int {
        
        notifyOn = notifyPreference // Bind notifyOn to the loaded value
        
        // Format the selected time for display.
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        // Create a Date object for the selected hour and minute.
        if let scheduledTime = Calendar.current.date(bySettingHour: selectedHour, minute: selectedMinute, second: 0, of: Date()) {
            notificationTime = formatter.string(from: scheduledTime)
        } else {
            print("Failed to create scheduled time.")
        }
    } else {
        print("Failed to load notification settings.")
    }
}

// Resets the saved notification time and cancels any existing notifications.
private func resetNotification() {
    // Remove notification time from UserDefaults
    UserDefaults.standard.removeObject(forKey: "selectedHour")
    UserDefaults.standard.removeObject(forKey: "selectedMinute")
    // Set notificationTime to nil
    notificationTime = nil
    // Cancel notifications
    cancelNotifications()
}

// Cancels all pending notifications.
private func cancelNotifications() {
    // Remove all pending notifications
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
}
    
}

    

//#Preview {
//    NotificationMainView()
//}
