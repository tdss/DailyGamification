//
//  DailyGamificationApp.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift

@main
struct DailyGamificationApp: SwiftUI.App {
    init() {
            
            let realm = try! Realm()
            let todos = realm.objects(GamificationDiary.self)
        if (!todos.isEmpty){
            gamification = todos[0]
        }
        else {
            gamification = GamificationDiary()
            try! realm.write {
                realm.add(gamification)
            }
        }
                
    }
    
    
    @ObservedRealmObject var gamification: GamificationDiary
 
    var body: some Scene {
        WindowGroup {
            let realm = try! Realm()
            let _ = print("User Realm User file location: \(realm.configuration.fileURL!.path)")
            DashBoard()
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Inside your application(application:didFinishLaunchingWithOptions:)

        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config

        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let realm = try! Realm()
    }

}

