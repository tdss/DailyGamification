//
//  CheckboxLog.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct ClaimTaskRow: View {
    @ObservedRealmObject var checkboxLog: CheckboxLog
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("+\(String(checkboxLog.multiplier))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    Text(checkboxLog.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
                if (!checkboxLog.current) {
                    Button(action: updateCheckboxLog) {
                        Text("CLAIM")
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                    }
                } else {
                    VStack {
                        Text("DONE!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text("(alltime: \(String($checkboxLog.allTime.wrappedValue)))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15).stroke( LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 4))
            .cornerRadius(15)
        }
        .padding(.horizontal)
    }

    
    private func updateCheckboxLog() {
        if let newItem = checkboxLog.thaw(),
           let realm = newItem.realm
        {
            try? realm.write {
                newItem.current = true
                newItem.allTime += 1
                newItem.dailyLogItem[0].dailyTotal += 1*newItem.multiplier
                newItem.dailyLogItem[0].historicalTotal += 1*newItem.multiplier
            }
        }
    }
}



struct ClaimTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        ClaimTaskRow(checkboxLog: GamificationDiary.getSampleToday().checkboxLogs[0])
    }
}
