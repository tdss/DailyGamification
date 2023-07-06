//
//  DashBoard.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift
import Charts

struct DashBoardView: View {
    @State var showingBottomSheet = false
    
    @ObservedResults(DailyLogItem.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: false)) var dailyLogItems
    @ObservedResults(DailyLogItem.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: true)) var dailyLogItemsReversed
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(dailyLogItems) { dailyLog in
                        NavigationLink(destination: DailyLogView(dailyLog: dailyLog)) {
                            DashboardItemRow(dailyLog: dailyLog)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .onDelete(perform: $dailyLogItems.remove)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.inset)

                Spacer()

                HStack {
                    addButton
                    Spacer()
                        .frame(width: 15)
                    showButton
                    Spacer()
                    totalPointsText
                }
                .padding()
                .background(Color.white.shadow(radius: 20, y: -5))
            }
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showingBottomSheet) {
            VStack {
                chartView
            }
            .presentationDetents([.medium, .large])
        }
    }

    var addButton: some View {
        RoundedButton(systemImageName: "plus", buttonAction: {
            if (dailyLogItems.count == 0) {
                $dailyLogItems.append(DailyLogItem())
            } else {
                let logItem =  dailyLogItems[0].copy()
                $dailyLogItems.append(logItem as! DailyLogItem)
            }
        })
    }
    
    var showButton: some View {
        RoundedButton(systemImageName: "chart.bar.xaxis", buttonAction: {
            showingBottomSheet.toggle()
        })
    }

    var totalPointsText: some View {
        Text((dailyLogItems.count > 0) ? "All time points: \(dailyLogItems[0].historicalTotal)" : "Get your first points!")
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
        
    }

    var chartView: some View {
        VStack {
            Chart {
                ForEach(Array(dailyLogItemsReversed.enumerated()), id: \.element) { index, element in
                    LineMark(
                        x: .value("Date", index),
                        y: .value("Points", element.historicalTotal)
                    )
                }
            }
            .frame(height: 200)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
            .overlay(
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Your Statistics")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.leading)
                    Spacer()
                }
            )
        }
        .padding(.horizontal)
    }
    
    var modalView:  some View {
        ZStack {
            chartView
        }
        .shadow(radius: 20)
        .blur(radius: 20)
        
    }
}


struct DashBoardView_Previews: PreviewProvider {
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
        
        return  DashBoardView().environment(\.realm, getRealm())
        
    }
}
