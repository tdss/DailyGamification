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
                HStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Image(systemName: "calendar")
                            .foregroundColor(.black)
                        Text("\(shortDate(date: dailyLog.date))")
                            .font(.headline)
                            .foregroundColor(.black)
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
                            .foregroundColor(.black)
                        Text("\(dailyLog.textLog.isEmpty ? "Your Log" : dailyLog.textLog)")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Image(systemName: "arrow.forward")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.2), radius: 10, y: 10)
    }
}



let dailyLogItem = DailyLogItem()

struct DashbordItemRow_Previews: PreviewProvider {
    static var previews: some View {
        DashboardItemRow(dailyLog: dailyLogItem)
    }
}
