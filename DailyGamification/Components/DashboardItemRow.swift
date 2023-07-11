//
//  DashbordItemRow.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 04/07/2023.
//

import SwiftUI
import RealmSwift


struct DashboardItemRow: View {
    @ObservedRealmObject var dailyLog: DailyLogItem
    
    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                        Text("\(shortDate(date: dailyLog.date))")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(dailyLog.dailyTotal)xp")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    }
                    HStack {
                        Image(systemName: "text.bubble")
                            .foregroundColor(.white)
                        Text("\(dailyLog.textLog)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}



let dailyLogItem = DailyLogItem()

struct DashbordItemRow_Previews: PreviewProvider {
    static var previews: some View {
        DashboardItemRow(dailyLog: dailyLogItem)
    }
}
