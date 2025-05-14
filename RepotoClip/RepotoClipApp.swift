//
//  RepotoClipApp.swift
//  RepotoClip
//
//  Created by Haejin Park on 2/4/25.
//

import SwiftUI

@main
struct RepotoClipApp: App {
    @StateObject private var manager = ReportManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(manager)
//                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
//                    guard let incomingURL = userActivity.webpageURL,
//                          let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
//                        return
//                    }
//                    
//                }
        }
    }
}
