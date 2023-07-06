//
//  AddNumericLogView.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 29/06/2023.
//

import SwiftUI
import RealmSwift


struct AddNumericLogView: View {
    @ObservedRealmObject var dailyLogItem: DailyLogItem
    
    @State private var name = ""
    @State private var multiplier = 1
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Text("Pick a name for it:")
                TextField("pushups", text: $name)
                Text("How much points per item? (1-easy, 10-hard):")
                
                Stepper("\(multiplier)",
                        value: $multiplier,
                        in: 1...10
                )
                
                Button {
                    
                    let numericLog = NumericLog()
                    numericLog.name = name
                    numericLog.multiplier = multiplier
                    if let newItem = dailyLogItem.thaw(),
                       let realm = newItem.realm
                    {
                        try? realm.write {
                            newItem.numericLogs.append(numericLog)
                        }
                    }
                    dismiss()
                } label: {
                    Text("SAVE")
                }
            }
        }
        
    }
}

struct AddNumericLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddNumericLogView(dailyLogItem: DailyLogItem())
    }
}
