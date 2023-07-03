//
//  NumericLog.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct NumericLogView: View {
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
                VStack{
                    HStack {
                        Text(String($numericLog.current.wrappedValue)).font(.title)
                        Text("(alltime: \(String($numericLog.allTime.wrappedValue)))").font(.body)
                    }
                    Text("\(numericLog.name) (x\(numericLog.multiplier))")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("+1")
                }.padding().background(Color(.systemBlue)).cornerRadius(15)
                    .foregroundColor(.white)
                    .onTapGesture {
                        
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
            }.padding(.horizontal, 5.0)
        }.sheet(isPresented: $isRewardPresented) {
            TADA(points: pointsEarned)
            
        }
    }
}

struct NumericLogView_Previews: PreviewProvider {
    static var previews: some View {
        NumericLogView(numericLog:GamificationDiary.getSampleToday().numericLogs[0])
    }
}
