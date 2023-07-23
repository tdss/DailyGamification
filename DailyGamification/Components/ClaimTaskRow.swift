//
//  CheckboxLog.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct ClaimTaskRow: View {
    @Environment(\.colorScheme) var colorScheme 
    @ObservedRealmObject var checkboxLog: CheckboxLog
    @Binding var confettiCounter: Int
    
    @State var isClaimButtonTapped: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("+\(String(checkboxLog.multiplier))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
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
                            .frame(width: 70, height: 40)
                            .font(.callout)
                            .fontWeight(.bold)
                            .background(.green)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
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
        }
        .background(colorScheme == .dark ? .black : .white)
        .cornerRadius(10)
        .shadow(color: colorScheme == .dark ? Color("Primary").opacity(0.8) : .black.opacity(0.2), radius: 10, x: -1,  y: 12)
        .padding(.horizontal)

    }
    
    
    private func updateCheckboxLog() {
        confettiCounter += 1
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
        ClaimTaskRow(checkboxLog: GamificationDiary.getSampleToday().checkboxLogs[0], confettiCounter: .constant(0))
    }
}
