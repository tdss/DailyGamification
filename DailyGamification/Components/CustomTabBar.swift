//
//  CustomTabBar.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 07/07/2023.
//

import SwiftUI

enum TabItem: String, CaseIterable, Hashable {
    case dashboard
    case blog
    case aboutApp
}

let imageNames = Dictionary(uniqueKeysWithValues: TabItem.allCases.map { ($0, "\($0)Icon") })


struct CustomTabBar: View {
    @Binding var selectedTab: TabItem
    
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    private var tabColor: Color {
        switch selectedTab {
        case .dashboard:
            return .blue
        case .blog:
            return .blue
        case .aboutApp:
            return .blue
        }
    }
    
    var body: some View {
        HStack {
            ForEach(TabItem.allCases, id: \.rawValue) {tab in
                Spacer()
                Image(imageNames[tab] ?? "placeholderIcon")
                    .renderingMode(.template)
                    .scaleEffect(selectedTab == tab ? 1.05 : 1.0)
                    .foregroundColor(selectedTab == tab ? tabColor : .gray)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = tab
                        }
                    }
                Spacer()
            }
        }
        .frame(width: nil, height: 70)
        .background(.thinMaterial)
        .cornerRadius(10)
        .padding()
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.aboutApp))
    }
}
