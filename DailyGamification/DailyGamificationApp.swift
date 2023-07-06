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
    @ObservedRealmObject var gamification: GamificationDiary
    
    init() {
        Self.setupRealmConfiguration()
        gamification = Self.loadOrInitiateGamification()
        Self.printRealmFileLocation()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView()
            }
        }
    }
}

extension DailyGamificationApp {
    static func setupRealmConfiguration() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    // Nothing to do! Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            }
        )

        Realm.Configuration.defaultConfiguration = config
        do {
            let _ = try Realm()
        } catch {
            print("Failed to open Realm: \(error)")
        }
    }

    static func loadOrInitiateGamification() -> GamificationDiary {
        do {
            let realm = try Realm()
            let todos = realm.objects(GamificationDiary.self)
            if let gamification = todos.first {
                return gamification
            } else {
                let gamification = GamificationDiary()
                try realm.write {
                    realm.add(gamification)
                }
                return gamification
            }
        } catch {
            print("Failed to manage GamificationDiary: \(error)")
            return GamificationDiary()  // Return a new instance as a fallback
        }
    }

    static func printRealmFileLocation() {
        do {
            let realm = try Realm()
            if let fileURL = realm.configuration.fileURL {
                print("User Realm User file location: \(fileURL.path)")
            }
        } catch {
            print("Failed to open Realm: \(error)")
        }
    }
}
