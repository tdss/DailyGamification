//
//  AboutAppView.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 07/07/2023.
//

import SwiftUI
import StoreKit

struct AboutAppView: View {
    @Environment(\.requestReview) var requestReview
    @StateObject var aboutUsModel: AboutUsModel = AboutUsModel()
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("AppIcon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            Text("DailyGamification")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Version 1.0.0)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("This is a great app to motivate you through gamification. Achieve your goals while having fun!")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            if(aboutUsModel.aboutUs.isEmpty == false ) {
                NavigationLink(destination: AboutUsView()) {
                    Text("About us")
                }
            }
            
            Spacer()
            
            Button(action: {
                EmailController.shared.sendEmail(subject: "", body: "", to: "dariusz@tdsoft.pl")
            }) {
                Text("Contact Us")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: {
                requestReview()
            }) {
                Text("Review")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            VStack(alignment: .center, spacing: 10) {
                Text("Developed by")
                    .font(.title3)
                
                Text("Company Name")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("All rights reserved")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
        }
        .task {
            await aboutUsModel.fetch()
        }
        .padding()
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
