//
//  TabAppView.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 07/07/2023.
//

import SwiftUI

struct TabAppView: View {
    @StateObject var aboutUsModel: AboutUsModel = AboutUsModel()
    var body: some View {
        TabView {
            DashBoardView()
                .tabItem {
                    Image("dashboardIcon")
                        .renderingMode(.template)
                        .resizable()
                }
            BlogView()
                .tabItem {
                    Image("blogIcon")
                        .renderingMode(.template)
                        .resizable()
                }
            AboutUsView()
                .tabItem {
                    Image("aboutAppIcon")
                        .renderingMode(.template)
                        .resizable()
                }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(Color("Primary"))
    }
}

struct TabAppView_Previews: PreviewProvider {
    static var previews: some View {
        TabAppView()
    }
}
