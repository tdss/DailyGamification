//
//  Helpers.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 01/07/2023.
//

import Foundation

func shortDate(date:Date) -> String
{
    let formatter1 = DateFormatter()
    formatter1.dateStyle = .short
    formatter1.timeStyle = .none
    formatter1.locale = Locale()

    return formatter1.string(from: date)
}
