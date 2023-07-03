//
//  TADA.swift
//  DailyGamification
//
//  Created by Dariusz Tarczynski on 02/07/2023.
//

import SwiftUI


struct TADA: View {
    @Environment(\.dismiss) var dismiss
    @State public var points = 5
    @State public var message = "Good Job!"
    
    @State private var position = -50
    @State private var scale = 1.0

    func animate() {
        let baseAnimation = Animation.easeInOut(duration: 0.2)
        let repeated = baseAnimation.repeatCount(12,autoreverses: true)
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            position = 140
        }
        withAnimation(repeated.delay(0.5)) {
            scale = 0.95
        }
        withAnimation(Animation.easeInOut(duration: 0.5).delay(1.5)) {
            position = -100
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
              dismiss()
            }
              
        }
    }

    var body: some View {
            VStack {
                Text("+\(points) XP")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                Text(message)
                    .foregroundColor(.white)
                    .font(.title)
            }.padding()
                .frame(width: UIScreen.main.bounds.width-10, height: 100)
                .background(Color(red: 0.3, green: 0.1, blue: 0.8))
                .cornerRadius(20)
                .position(CGPoint(x: Int(UIScreen.main.bounds.width/2), y: Int(position)))
                .scaleEffect(scale)
                .onTapGesture {
                   dismiss()
                }.onAppear{
                    animate()
                }.presentationBackground(.clear)
    }
    
}

struct TADA_Previews: PreviewProvider {
    static var previews: some View {
        TADA()
    }
}
