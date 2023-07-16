//
//  DailyLogView.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 29/06/2023.
//

import SwiftUI
import RealmSwift
import ConfettiSwiftUI

struct DailyLogView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedRealmObject var dailyLog: DailyLogItem
    @State private var isNumericPresented: Bool = false
    @State private var isCheckboxPresented: Bool = false
    @State var confettiCounter: Int = 0
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            header
            logSelection
            Spacer()
                .frame(height: 20)
            dailyLogsList
            buttonsTab
        }
        .confettiCannon(counter: $confettiCounter, num: 150, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
        .sheet(isPresented: $isNumericPresented) {
           numericBottomSheet
        }
        .sheet(isPresented: $isCheckboxPresented) {
            checkboxBottomSheet
        }
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            Text((dailyLog.dailyTotal > 0) ? "DailyTotal : \(dailyLog.dailyTotal)" : "Get started!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .padding(.bottom, 10)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean auctor ex libero, eu pulvinar massa.")
                .font(.body)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
                .padding(.bottom, 10)
            
            Text("For: \(shortDate(date: dailyLog.date))")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.footnote)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
        }
        .padding()
        .background(  colorScheme == .dark ?
            .black : .white
        )
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    var logSelection: some View {
        VStack(alignment: .leading) {
            Text("How are you today?")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.bottom, 10)
            
            TextField("", text: $dailyLog.textLog, prompt: Text("Your log").foregroundColor(.gray))
                .background(.white)
                .foregroundColor(.black)
                .textFieldStyle(.roundedBorder)
                .cornerRadius(2)
            Spacer()
                .frame(height: 20)
            Picker(
                selection: $dailyLog.emoji,
                label: Text("Picker"),
                content: {
                    ForEach(emojis, id: \.self) { emoji in
                        Text("\(emoji)").tag("\(emoji)")
                    }
                }
            )
            .pickerStyle(.segmented)
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .padding([.horizontal, .top])
    }
    
    var dailyLogsList: some View {
        VStack {
            if(dailyLog.numericLogs.count >= 1 || dailyLog.checkboxLogs.count >= 1) {
                List {
                    ForEach(dailyLog.numericLogs) { numericLog in
                        NumericLogRow(numericLog: numericLog)
                            .listRowInsets(EdgeInsets())
                            .padding(.vertical, 8)
                    }
                    .onDelete(perform: $dailyLog.numericLogs.remove)
                    .listRowSeparator(.hidden)
                    
                    ForEach(dailyLog.checkboxLogs) { checkboxLog in
                        ClaimTaskRow(checkboxLog: checkboxLog, confettiCounter: $confettiCounter)
                            .listRowInsets(EdgeInsets())
                            .padding(.vertical, 8)
                    }
                    .onDelete(perform: $dailyLog.checkboxLogs.remove)
                    .listRowSeparator(.hidden)
                }
                .scrollIndicators(.hidden)
                .listStyle(.inset)
                .background(Color.white)
            }else {
                VStack {
                    Spacer()
                    Text("Add your logs")
                    Spacer()
                }
            }
        }
    }
    
    var buttonsTab: some View {
        HStack {
            PrimaryButton(
                title: "Add Counter",
                imageSystemName:"arrow.counterclockwise.circle",
                backgroundColor: .purple,
                buttonAction: {
                    isNumericPresented = true
                })
            PrimaryButton(
                title: "Add Check",
                imageSystemName:"checkmark.circle",
                backgroundColor: .blue,
                buttonAction: {
                    isCheckboxPresented = true
                })
        }
        .padding()
    }
    
    var numericBottomSheet: some View {
        AddLogView(dailyLogItem: dailyLog, achievementType: .numeric) { name, multiplier, dailyLogItem in
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
        }
        .presentationDetents([.height(500), .large])
    }
    
    var checkboxBottomSheet: some View {
        AddLogView(dailyLogItem: dailyLog, achievementType: .checkbox) { name, multiplier, dailyLogItem in
            let checkboxLog = CheckboxLog()
            checkboxLog.name = name
            checkboxLog.multiplier = multiplier
            if let newItem = dailyLogItem.thaw(),
               let realm = newItem.realm
            {
                try? realm.write {
                    newItem.checkboxLogs.append(checkboxLog)
                }
            }
        }
        .presentationDetents([.height(500), .large])
    }
}

struct DailyLogView_Previews: PreviewProvider {
    static var previews: some View {
        DailyLogView(dailyLog: GamificationDiary.getSampleToday())
    }
}
