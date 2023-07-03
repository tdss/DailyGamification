//
//  DailyLogView.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 29/06/2023.
//

import SwiftUI
import RealmSwift

struct DailyLogView: View {
    @ObservedRealmObject var dailyLog: DailyLogItem
    @State private var isNumericPresented: Bool = false
    @State private var isCheckboxPresented: Bool = false
    let dateFormatter = DateFormatter()

    var body: some View {
        NavigationView {
            
        VStack {
            Text("For: \(shortDate(date: dailyLog.date))") .frame(maxWidth: .infinity, alignment: .trailing).padding()
            GroupBox {
                Text("How are you today?")
                TextField("your log", text: $dailyLog.textLog)
                    .textFieldStyle(.roundedBorder)
            }
                List {
                    ForEach(dailyLog.numericLogs) { numericLog in
                        NumericLogView(numericLog: numericLog)
                        
                    }.onDelete(perform: $dailyLog.numericLogs.remove)

                    ForEach(dailyLog.checkboxLogs) { checkboxLog in
                        CheckboxLogView(checkboxLog: checkboxLog)
                        
                    }.onDelete(perform: $dailyLog.checkboxLogs.remove)
                }

        }.sheet(isPresented: $isNumericPresented, content: {
            AddNumericLogView(dailyLogItem: dailyLog)
        }).sheet(isPresented: $isCheckboxPresented, content: {
            AddCheckboxLogView(dailyLogItem: dailyLog)
        }).toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isNumericPresented = true
                    //AddNumericLogView(dailyLogItem: dailyLog)
                    //$dailyLog.numericLogs.append(NumericLog())
                } label: {
                    Text("add counter")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isCheckboxPresented = true
                    //AddNumericLogView(dailyLogItem: dailyLog)
                    //$dailyLog.numericLogs.append(NumericLog())
                } label: {
                    Text("add check")
                }
            }
        }.navigationBarTitle(
            (dailyLog.dailyTotal > 0) ? "DailyTotal : \(dailyLog.dailyTotal)" : "Get started!")
            
        }


    }
}

struct DailyLogView_Previews: PreviewProvider {
    static var previews: some View {
        
        DailyLogView(dailyLog: GamificationDiary.getSampleToday())
    }
}
