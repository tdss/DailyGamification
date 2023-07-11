//
//  LottieView.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 07/07/2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        
        // Add constraints to the animationView
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        animationView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        animationView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        animationView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        animationView.play()
        
        
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
    
    }
}
