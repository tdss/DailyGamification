//
//  CheckboxLog.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 27/06/2023.
//

import SwiftUI
import RealmSwift

struct CheckboxLogView: View {
    @ObservedRealmObject var checkboxLog: CheckboxLog
    
    var body: some View {
        
        HStack(){
            VStack {
                Text("+\(String(checkboxLog.multiplier))").font(.title)
                Text(checkboxLog.name)
            }
            Spacer()
            if (!checkboxLog.current) {
                Button {
                    
                } label: {
                    Text("CLAIM")
                }.padding().background(Color(.systemBlue)).cornerRadius(15)
                    .foregroundColor(.white)
                    .onTapGesture {
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
                

            } else {
                VStack{
                    Text("DONE!").font(.title)
                    Text("(alltime: \(String($checkboxLog.allTime.wrappedValue)))").font(.body)
                }
           
            }

        }.padding(.horizontal, 5.0)
            
    }
}

struct CheckboxLogView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxLogView(checkboxLog: GamificationDiary.getSampleToday().checkboxLogs[0])
    }
}
