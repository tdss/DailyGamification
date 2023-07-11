//
//  ContentView.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedRealmObject var gamification: GamificationDiary

    var body: some View {
       TabAppView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(gamification: GamificationDiary())
    }
}
