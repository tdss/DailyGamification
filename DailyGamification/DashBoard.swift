//
//  DashBoard.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift
import Charts

struct DashBoard: View {
    @ObservedResults(DailyLogItem.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: false)) var dailyLogItems
    @ObservedResults(DailyLogItem.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: true)) var dailyLogItemsReversed
    //@ObservedResults var
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach(dailyLogItems) { dailyLog in
                        ItemRow(dailyLog: dailyLog)
                        
                    }.onDelete(perform: $dailyLogItems.remove)
                    
                }
                Spacer()
                Text((dailyLogItems.count > 0) ? "All time points: \(dailyLogItems[0].historicalTotal)" : "Get your first points!")
                Chart {
                    ForEach(Array(dailyLogItemsReversed.enumerated()), id: \.element) { index, element in
                                AreaMark(
                                    x: .value("Date", index),
                                    y: .value("Points", element.historicalTotal)
                                )
                        }
                }.frame(height: 100).padding()
                
            }

        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("1% better everyday!", displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    if (dailyLogItems.count == 0) {
                        $dailyLogItems.append(DailyLogItem())
                    } else {
                        let logItem =  dailyLogItems[0].copy()
                        $dailyLogItems.append(logItem as! DailyLogItem)
                    }
                } label: {
                    Text("Add new daily log!")
                }
            }
        }
        
        
    }
}

struct ItemRow: View {
    @ObservedRealmObject var dailyLog: DailyLogItem;
    // Create Date Formatter
    
    var body: some View {
        
        NavigationLink(destination: DailyLogView(dailyLog: dailyLog)) {
            Text("\(shortDate(date: dailyLog.date)) - \(dailyLog.dailyTotal)xp - \(dailyLog.textLog)")
        }
    }
}

struct DashBoard_Previews: PreviewProvider {
    static var previews: some View {

        func getRealm() -> Realm {
            var conf = Realm.Configuration.defaultConfiguration
            conf.inMemoryIdentifier = "preview"
            
            let realm = try!  Realm(configuration: conf)
            
            let allItems = realm.objects(DailyLogItem.self)
            
            if allItems.count == 0 {
                try? realm.write({
                    let item2 = DailyLogItem()
                    item2.dailyTotal = 50
                    item2.historicalTotal = 50
                    item2.date = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
                    let item = DailyLogItem()
                    item.dailyTotal = 30
                    item.historicalTotal = 80
                    item.date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                    realm.add(item2)
                    realm.add(item)
                    let item3 = DailyLogItem()
                    item3.historicalTotal = 80
                    realm.add(item3)
                })
            }
            return realm;
        }
        
        return NavigationStack {
            DashBoard().environment(\.realm, getRealm())
        }
    }
}
