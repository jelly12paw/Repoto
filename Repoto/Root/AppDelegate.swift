//
//  AppDelegate.swift
//  Repoto
//
//  Created by Haejin Park on 1/20/25.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NotificationCenter.default.post(name: .handleOpenURL, object: url)
        return true
    }
}


import SwiftData

@Model
final class ReportModel {
    @Attribute(.unique) var id: UUID
    var date: Date
    var category: String
    var toiletSection: String = ""
    var washbasinSection: String = ""
    var reports: Set<String> = [""]
    var gender: String = ""
    var floor: String = ""
    
    init(id: UUID, date: Date, category: String, toiletSection: String, washbasinSection: String, reports: Set<String>, gender: String, floor: String) {
        self.id = id
        self.date = date
        self.category = category
        self.toiletSection = toiletSection
        self.washbasinSection = washbasinSection
        self.reports = reports
        self.gender = gender
        self.floor = floor
    }
}
