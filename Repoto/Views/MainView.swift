//
//  MainView.swift
//  Repoto
//
//  Created by Haejin Park on 1/16/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var manager: ReportManager
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HeaderView()
                    .padding(.bottom, 28)
                
                LocationView()
            }
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationDestination(item: $manager.selectedLocation) { location in
                ReportView()
                    .navigationTitle(locationTitle[location] ?? "")
            }
        }
    }
}

private struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("시설 신고하기")
                .font(.system(size: 34, weight: .bold))
                .padding(.bottom, 10)
            
            Text("깨끗한 화장실을 함께 만들어요")
                .font(.system(size: 18, weight: .regular))
        }
    }
}

private struct LocationView: View {
    @EnvironmentObject var manager: ReportManager
    
    private let locations = [
        ("6층", [
            ("male_lightgray", "male_blue", 1),
            ("female_lightgray", "female_blue", 2)
        ]),
        ("5층", [
            ("male_lightgray", "male_blue", 3),
            ("female_lightgray", "female_blue", 4)
        ])
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(locations.indices, id: \.self) { index in
                let (floor, buttons) = locations[index]
                
                Text(floor)
                    .font(.system(size: 22, weight: .bold))
                    .padding(.bottom, 12)
                    .padding(.top, index > 0 ? 40 : 0)
                
                HStack {
                    ForEach(buttons, id: \.2) { (defaultImage, selectedImage, locationID) in
                        Button(action: {
                            manager.selectedLocation = locationID
                        }) {
                            Image(manager.selectedLocation == locationID ? selectedImage : defaultImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width * 0.44)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
