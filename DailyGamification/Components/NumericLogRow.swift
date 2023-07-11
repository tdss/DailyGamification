//
//  NumericLog.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct NumericLogRow: View {
    @ObservedRealmObject var numericLog: NumericLog
    
    @State private var current = 0
    @State private var isRewardPresented = false
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
                            .foregroundColor(.green)
                        Text("(alltime: \(String($numericLog.allTime.wrappedValue)))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text("\(numericLog.name) (x\(numericLog.multiplier))")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                Spacer()
                Button(action: updateNumericLog) {
                    Text("+1")
                        .frame(width: 50, height: 50)
                        .font(.callout)
                        .fontWeight(.bold)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(25)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15).stroke( LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 4))
            .cornerRadius(15)
        }
        .padding(.horizontal)
        .sheet(isPresented: $isRewardPresented) {
            TADA(points: pointsEarned)
        }
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
                isRewardPresented = true
            }
        }
    }
}


struct NumericLogRow_Previews: PreviewProvider {
    static var previews: some View {
        NumericLogRow(numericLog:GamificationDiary.getSampleToday().numericLogs[0])
    }
}
