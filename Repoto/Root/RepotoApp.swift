//
//  RepotoApp.swift
//  Repoto
//
//  Created by Haejin Park on 1/16/25.
//

import SwiftUI

@main
struct RepotoApp: App {
    @StateObject private var manager = ReportManager()

    var body: some Scene {
        WindowGroup {
            Group {
                if manager.source == .inApp {
                    MainView()
                        .environmentObject(manager)
                } else {
                    LinkView()
                        .environmentObject(manager)
                }
            }
            .onOpenURL { url in
                manager.urlHandler(url)
            }
        }
    }
}
