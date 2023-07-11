//
//  DailyLogView.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 29/06/2023.
//

import SwiftUI
import RealmSwift

struct DailyLogView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedRealmObject var dailyLog: DailyLogItem
    @State private var isNumericPresented: Bool = false
    @State private var isCheckboxPresented: Bool = false
    @State private var selection: String = "💪"
    @State var showingBottomSheet = false
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            header
            logSelection
            HStack {
                Button(action: {
                    isNumericPresented = true
                    showingBottomSheet = true
                    
                }) {
                    Text("Add Counter")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(Color.blue))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    isCheckboxPresented = true
                    showingBottomSheet = true
                }) {
                    Text("Add Check")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(Color.green))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
            
            
            
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
                        ClaimTaskRow(checkboxLog: checkboxLog)
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
        .sheet(isPresented: $showingBottomSheet) {
            if(isNumericPresented) {
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
            }else {
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
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            Text((dailyLog.dailyTotal > 0) ? "DailyTotal : \(dailyLog.dailyTotal)" : "Get started!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.purple)
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
                      LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing) :
                      LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .leading, endPoint: .trailing))
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
                .padding(5)
                .background(.white)
                .foregroundColor(.black)

            /**TODO: implement */
            Spacer()
                .frame(height: 20)
            Picker(
                selection: $selection,
                label: Text("Picker"),
                content: {
                    Text("💪").tag("💪")
                    Text("😩").tag("😩")
                    Text("😝").tag("😩")
                    Text("😭").tag("😭")
                }
            )
            .pickerStyle(.segmented)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke( LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 4))
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
        .padding([.horizontal, .top])
    }
}

struct DailyLogView_Previews: PreviewProvider {
    static var previews: some View {
        
        DailyLogView(dailyLog: GamificationDiary.getSampleToday())
    }
}
