//
//  TabAppView.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 07/07/2023.
//

import SwiftUI

struct TabAppView: View {
    @State private var selectedTab: TabItem = .dashboard
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    private var tabView: some View {
        switch selectedTab {
        case .dashboard:
            return AnyView(DashBoardView())
        case .blog:
            return AnyView(BlogView())
        case .aboutApp:
            return AnyView(AboutAppView())
        }
    }
    
    var body: some View {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        ForEach(TabItem.allCases, id: \.rawValue) { tab in
                            HStack {
                                tabView
                            }
                            .tag(tab)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                }
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
    }
}

struct TabAppView_Previews: PreviewProvider {
    static var previews: some View {
        TabAppView()
    }
}
