//
//  WelcomeView.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 04/07/2023.
//

import SwiftUI
import Lottie

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer()

            Text("Welcome to DailyGamification")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text("Experience the fun of daily tasks with a gamified twist!")
                .font(.title)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 10)

            Spacer()

//            Image("welcomeImage")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .padding(.horizontal)
//
            LottieView(name: LottieFilesConstants.up, loopMode: .loop, animationSpeed: 0.5)
                .frame(width: 300, height: 300)
            


            Spacer()

            NavigationLink(destination: TabAppView()) {
                Text("Get Started")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
