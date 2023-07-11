//
//  AddLogView.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 07/07/2023.
//

import SwiftUI
import RealmSwift

enum AchievementType {
    case numeric
    case checkbox
}

struct AddLogView: View {
    @ObservedRealmObject var dailyLogItem: DailyLogItem
    let achievementType: AchievementType
    let saveAction: (String, Int, DailyLogItem) -> Void
    
    @State private var name = ""
    @State private var multiplier = 1.0
    @State private var toast: Toast? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("New \(achievementType == .numeric ? "Numeric" : "") Achievement")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Achievement Name")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    TextField("", text: $name, prompt: Text("E.g., Push-ups").foregroundColor(.gray))
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                }
                
                VStack {
                    Text("\(achievementType == .numeric ? "Points per Item" : "Difficulty Level"): \(Int(multiplier))")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer().frame(height: 5)
                    Text("How much points \(achievementType == .numeric ? "per item" : "for completion")? (1-easy, 10-hard):")
                        .font(.callout)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Slider(value: $multiplier, in: 1...10, step: 1)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    if(name.isEmpty) {
                        toast = Toast(type: .error, title: "Missing name", message: "Provide name for your achievement")
                    }else {
                        saveAction(name, Int(multiplier), dailyLogItem)
                        dismiss()
                    }
                }) {
                    Text("SAVE")
                        .frame(maxWidth: .infinity)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .toastView(toast: $toast)
            .padding(.horizontal, 20)
        }
    }
}


struct AddLogView_Previews: PreviewProvider {
    static var previews: some View {
        let dailyLogItem = DailyLogItem() // Create a dummy DailyLogItem

        Group {
            AddLogView(dailyLogItem: dailyLogItem, achievementType: .numeric, saveAction: { _, _, _ in
                // This is just a dummy action for the preview
            })
            .previewDisplayName("Numeric Achievement")

            AddLogView(dailyLogItem: dailyLogItem, achievementType: .checkbox, saveAction: { _, _, _ in
                // This is just a dummy action for the preview
            })
            .previewDisplayName("Checkbox Achievement")
        }
    }
}

