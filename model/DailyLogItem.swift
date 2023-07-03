//
//  DailyLogItem.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 28/06/2023.
//

import Foundation
import RealmSwift


class GamificationDiary: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id:  ObjectId
    @Persisted var dailyLogItems = RealmSwift.List<DailyLogItem>()
    @Persisted var total = 0
    
    static func getSampleToday() -> DailyLogItem
    {
        let dailyLogItem = DailyLogItem()
        dailyLogItem.date = Date.now
        let numericLog = NumericLog()
        numericLog.name = "Pushups"
        let numericLog2 = NumericLog()
        numericLog2.name = "Pages read"
        numericLog2.multiplier = 10
        numericLog2.current = 44
        numericLog2.allTime = 90
        let checkboxLog = CheckboxLog()
        checkboxLog.name = "Record a video"
        checkboxLog.current = true
        checkboxLog.allTime = 5
        checkboxLog.multiplier = 10
        let checkboxLog2 = CheckboxLog()
        checkboxLog2.name = "Write some book"
        let checkboxLog3 = CheckboxLog()
        checkboxLog3.name = "Work on udemy gamification course"
        dailyLogItem.checkboxLogs.append(checkboxLog)
        dailyLogItem.checkboxLogs.append(checkboxLog2)
        dailyLogItem.checkboxLogs.append(checkboxLog3)
        dailyLogItem.checkboxLogs.append(checkboxLog3)
        dailyLogItem.numericLogs.append(numericLog)
        dailyLogItem.numericLogs.append(numericLog2)
        return dailyLogItem;
    }
}

class DailyLogItem: Object, ObjectKeyIdentifiable, NSCopying {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var numericLogs = RealmSwift.List<NumericLog>()
    @Persisted var checkboxLogs = RealmSwift.List<CheckboxLog>()
    @Persisted var dailyTotal = 0
    @Persisted var historicalTotal = 0
    @Persisted var date = Date.now
    @Persisted var textLog = ""
    
    @Persisted(originProperty: "dailyLogItems") var gamificationDiary: LinkingObjects<GamificationDiary>
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = DailyLogItem()
        copy.historicalTotal = historicalTotal
        numericLogs.forEach { numericLog in
            let tmpNumericLog = NumericLog()
            tmpNumericLog.name = numericLog.name
            tmpNumericLog.allTime = numericLog.allTime
            tmpNumericLog.multiplier = numericLog.multiplier
            copy.numericLogs.append(tmpNumericLog)
        }
        checkboxLogs.forEach { checkboxLog in
            let tmpCheckboxLog = CheckboxLog()
            tmpCheckboxLog.name = checkboxLog.name
            tmpCheckboxLog.allTime = checkboxLog.allTime
            tmpCheckboxLog.multiplier = checkboxLog.multiplier
            copy.checkboxLogs.append(tmpCheckboxLog)
        }
        return copy
    }
}

class CheckboxLog: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var multiplier = 10
    @Persisted var current = false
    @Persisted var allTime = 0
    @Persisted var name: String

    @Persisted(originProperty: "checkboxLogs") var dailyLogItem: LinkingObjects<DailyLogItem>
}

class NumericLog: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var multiplier = 1
    @Persisted var current = 0
    @Persisted var allTime = 0
    @Persisted var name: String

    @Persisted(originProperty: "numericLogs") var dailyLogItem: LinkingObjects<DailyLogItem>
}
