//
//  test.swift
//  Repoto
//
//  Created by Haejin Park on 5/12/25.
//

import SwiftUI

struct testView: View {
    var body: some View {
        Image("toiletclogged_gray")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width * 0.3)
            .foregroundStyle(.blue)
    }
}

#Preview {
    testView()
}
