//
//  Loader.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 16/07/2023.
//

import SwiftUI

struct Loader: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("Primary")))
                .scaleEffect(2)
            Spacer()
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}

