//
//  NumericLog.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct NumericLogRow: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedRealmObject var numericLog: NumericLog
    
    @State private var current = 0
    @State private var pointsEarned = 0
    
    init(numericLog: NumericLog) {
        self.numericLog = numericLog
        _current = State(initialValue: numericLog.current)
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading){
                    HStack {
                        Text(String($numericLog.current.wrappedValue))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                        Text("(alltime: \(String($numericLog.allTime.wrappedValue)))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text("\(numericLog.name) (x\(numericLog.multiplier))")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                Spacer()
                Button(action: updateNumericLog) {
                    Text("+1")
                        .frame(width: 70, height: 40)
                        .font(.callout)
                        .fontWeight(.bold)
                        .background(colorScheme == .dark ? .black : .white)
                        .cornerRadius(10)
                        .foregroundColor(colorScheme == .dark ? .white : .gray)
                        .shadow(color: colorScheme == .dark ? Color("Primary").opacity(0.8) : .black.opacity(0.2), radius: 10,  y: 5)
                }
            }
            .padding()
        }
        .background(colorScheme == .dark ? .black : .white)
        .cornerRadius(10)
        .shadow(color: colorScheme == .dark ? Color("Primary").opacity(0.8) : .black.opacity(0.2), radius: 10, x: -1,  y: 12)
        .padding(.horizontal)

    }
    
    private func updateNumericLog() {
        if let newItem = numericLog.thaw(),
           let realm = newItem.realm
        {
            try? realm.write {
                newItem.current += 1
                newItem.allTime += 1
                newItem.dailyLogItem[0].dailyTotal += 1*newItem.multiplier
                newItem.dailyLogItem[0].historicalTotal += 1*newItem.multiplier
                pointsEarned = 1*newItem.multiplier
            }
        }
    }
}


struct NumericLogRow_Previews: PreviewProvider {
    static var previews: some View {
        NumericLogRow(numericLog:GamificationDiary.getSampleToday().numericLogs[0])
    }
}
