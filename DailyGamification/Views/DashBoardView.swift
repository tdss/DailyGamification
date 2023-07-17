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
    @State var showingBottomSheet: Bool = false
    @State var isAddButtonAnimating: Bool = false
    
    @ObservedResults(DailyLogItem.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: false)) var dailyLogItems
    @ObservedResults(DailyLogItem.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: true)) var dailyLogItemsReversed
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    addButton
                    Spacer()
                        .frame(width: 15)
                    showButton
                    Spacer()
                    totalPointsText
                }
                .padding()
                dailyLogsList
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationTitle("Dashboard")
        .sheet(isPresented: $showingBottomSheet) {
                chartView
            .presentationDetents([.medium, .large])
        }
    }

    var addButton: some View {
        RoundedButton(systemImageName: "plus", buttonAction: {
            if (dailyLogItems.count == 0) {
                $dailyLogItems.append(DailyLogItem())
                self.isAddButtonAnimating = false
                print(isAddButtonAnimating)
            } else {
                let logItem =  dailyLogItems[0].copy()
                $dailyLogItems.append(logItem as! DailyLogItem)
                self.isAddButtonAnimating = false
            }
        })
    }
    
    var showButton: some View {
        RoundedButton(systemImageName: "chart.bar.xaxis", buttonAction: {
            showingBottomSheet.toggle()
        })
    }
    
    var totalPointsText: some View {
        HStack {
            Text((dailyLogItems.count > 0) ? "All time points:" : "Get your first points!")
                .font(.headline)
                .foregroundColor(.gray)
            HStack(spacing: 2) {
                Text("\(dailyLogItems.isEmpty == false ?  dailyLogItems[0].historicalTotal : 0)")
                    .font(.headline)
                    .foregroundColor(.yellow)
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .frame(width: 220, height: 50)
        .background(.white)
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
    
    var dailyLogsList: some View {
        VStack {
            if(dailyLogItems.count >= 1) {
                List {
                    ForEach(dailyLogItems) { dailyLog in
                        ZStack {
                            NavigationLink(destination: DailyLogView(dailyLog: dailyLog)) {
                                EmptyView()
                            }
                            .buttonStyle(PlainButtonStyle())
                            DashboardItemRow(dailyLog: dailyLog)
                        }
                        
                    }
                    .onDelete(perform: $dailyLogItems.remove)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.inset)
                .scrollIndicators(.hidden)
            }else {
                VStack {
                    Spacer()
                    Text("Add your first log")
                    Spacer()
                }
            }
        }
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
