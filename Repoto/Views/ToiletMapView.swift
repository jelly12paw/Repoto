//
//  ToiletMapView.swift
//  Repoto
//
//  Created by Haejin Park on 1/17/25.
//

import SwiftUI

struct ToiletMapView: View {
    @EnvironmentObject var manager: ReportManager
    
    var body: some View {
        ZStack {
            Image("toilet_\(manager.selectedNumber)")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .padding(.horizontal, 16)
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width / 2.3)
                    ButtonAreaView(number: 1)
                    ButtonAreaView(number: 2)
                }
                
                HStack(spacing: 0) {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width / 4.5)
                    ButtonAreaView(number: 3)
                    ButtonAreaView(number: 4)
                    ButtonAreaView(number: 5)
                }
            }
        }
    }
}

private struct ButtonAreaView: View {
    @EnvironmentObject var manager: ReportManager
    
    let number: Int
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
            .contentShape(Rectangle())
            .onTapGesture {
                manager.selectedNumber = number
            }
    }
}
