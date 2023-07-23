//
//  DashbordItemRow.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 04/07/2023.
//

import SwiftUI
import RealmSwift


struct DashboardItemRow: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedRealmObject var dailyLog: DailyLogItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Image(systemName: "calendar")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("\(shortDate(date: dailyLog.date))")
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    Spacer()
                    HStack(alignment: .center) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(dailyLog.dailyTotal)xp")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    }
                }
                Spacer()
                    .frame(height: 5)
                HStack {
                    HStack(alignment: .center) {
                        Image(systemName: "text.bubble")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("\(dailyLog.emoji) \(dailyLog.textLog.isEmpty ? "Your Log" : dailyLog.textLog)")
                            .font(.subheadline)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    Spacer()
                    Image(systemName: "arrow.forward")
                        .foregroundColor(colorScheme == .dark ? .white : .gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(colorScheme == .dark ? .black : .white)
        .cornerRadius(10)
        .shadow(color: colorScheme == .dark ? Color("Primary").opacity(0.8) : .black.opacity(0.2), radius: 10, x: -1,  y: 12)
    }
}



let dailyLogItem = DailyLogItem()

struct DashbordItemRow_Previews: PreviewProvider {
    static var previews: some View {
        DashboardItemRow(dailyLog: dailyLogItem)
    }
}
