
//
//  AddNotificationView.swift
//  DailyTasks Watch App
//
//  Created by Joshua Cox on 4/23/24.
//

import SwiftUI
import UserNotifications


struct AddNotificationView: View {
    @State var selectedHour: Int = 0
    @State var selectedMinute: Int = 0
    @Environment(\.dismiss) var dismiss

    // View for adding a notification in the DailyTasks Watch App.
    // Users can select a time for their notification using two pickers (hour and minute).
    var body: some View {
        VStack {
            // Displays the pickers for hour and minute selection side by side.
            HStack {
                Picker("Hour", selection: $selectedHour) {
                    ForEach(0..<24) { hour in
                        Text(hour < 10 ? "0\(hour)" : "\(hour)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                Text(":")
                    .font(.title)
                
                Picker("Min", selection: $selectedMinute) {
                    ForEach(0..<60) { minute in
                        Text(minute < 10 ? "0\(minute)" : "\(minute)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
        Text("\(selectedHour < 10 ? "0\(selectedHour)" : "\(selectedHour)") : \(selectedMinute < 10 ? "0\(selectedMinute)" : "\(selectedMinute)")")
            Button(action: {
                scheduleNotification()
                saveNotificationDetails()
                dismiss()
            }) {
                Text("Create Notification")
                    .foregroundColor(.green)
            }
            .ignoresSafeArea()
            
        }
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to do your daily tasks today!"
        
        var dateComponents = DateComponents()
        dateComponents.hour = selectedHour
        dateComponents.minute = selectedMinute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "uniqueIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                if let scheduledTime = Calendar.current.date(from: dateComponents) {
                    let notificationTimeString = formatter.string(from: scheduledTime)
                    print("Notification scheduled successfully for \(notificationTimeString)")
                }
            }
        }
    }
    

    
    private func saveNotificationDetails() {
        UserDefaults.standard.set(selectedHour, forKey: "selectedHour")
        UserDefaults.standard.set(selectedMinute, forKey: "selectedMinute")
    }
}

//#Preview {
//    AddNotificationView()
//}
