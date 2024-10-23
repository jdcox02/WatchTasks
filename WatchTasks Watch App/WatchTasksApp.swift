import SwiftUI
import SwiftData
import WatchKit

// Entry point for the DailyTasks Watch App.
@main
struct WatchTasks_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor var applicationDelegate: ApplicationDelegate
    
    // Tracks the current state of the app (active, inactive, background).
    @Environment(\.scenePhase) var scenePhase
    
    // Initialization block where we can set up things when the app starts.
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Sets up a background task that triggers at app refresh events, identified as "MIDNIGHT_RESET".
        .backgroundTask(.appRefresh("MIDNIGHT_RESET")) {
            print("Background Task called")
            await DataManager.shared.resetDay()
            
            // Retrieves the current date and compares it to the last stored date.
            let currentDate = Calendar.current.startOfDay(for: Date())
            let lastStoredDate = UserDefaults.standard.object(forKey: "currentDate") as? Date ?? currentDate

            // Checks if a new day has started.
            if !Calendar.current.isDate(currentDate, inSameDayAs: lastStoredDate) {
                print("A new day has started. Resetting tasks and creating task history.")
                await DataManager.shared.resetDay()
                UserDefaults.standard.set(currentDate, forKey: "currentDate")
            } else {
                print("No date change detected.")
            }
        }
        // Associates the shared model container for managing task data.
        .modelContainer(DataManager.shared.sharedModelContainer)
        .onChange(of: scenePhase) {oldPhase, newPhase in
            if newPhase == .inactive {
                print("inactive")
            } else if newPhase == .active {
                print("active")
            } else if newPhase == .background {
                print("background")
            }
            
        }
    }
    

}
