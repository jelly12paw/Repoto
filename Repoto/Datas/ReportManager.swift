//
//  ReportManager.swift
//  Repoto
//
//  Created by Haejin Park on 1/20/25.
//

import SwiftUI
import MessageUI

class ReportManager: ObservableObject {
    @Published var selectedLocation: Int?
    @Published var selectedNumber: Int = 0
    @Published var reportContent: String?
    @Published var source: LocationSource = .inApp
    
    let defaults = UserDefaults.standard
    
    let loc = UserDefaults.standard.integer(forKey: "loc")
    let reloc = UserDefaults.standard.integer(forKey: "reloc")
    let content = UserDefaults.standard.string(forKey: "content")
    
    
    enum LocationSource {
        case link
        case inApp
    }
    
    func setLocation(_ locationID: Int) {
        defaults.set(locationID, forKey: "loc")
    }
    
    func setReportLocation(_ reportLocationID: Int) {
        defaults.set(reportLocationID, forKey: "reloc")
    }
    
    func setReportContent(_ content: String?) {
        defaults.set(content, forKey: "content")
    }
    
    func urlHandler(_ url: URL) {
        let parameters = url.extractQueryParameters()
        let loc = parameters["loc"].flatMap{ Int($0) }
        let reloc = Int(parameters["reloc"] ?? "") ?? 0
        
        source = .link
        setLocation(loc ?? 0)
        setReportLocation(reloc)
    }
    
    func openTeamsChat() {
        let email = "jelly09@postech.ac.kr"
        var message: String
        
        switch source {
        case .inApp:
            message = "\(reportIcon[reportContent]!) \(locationTitle[selectedLocation]!) \(numberTitle[selectedNumber]!)\(reportTitle[reportContent]!)"
        case .link:
            message = "\(locationIcon[loc]!)\(numberIcon[reloc]!)\(reportIcon[reportContent]!)\n\(locationTitle[loc]!) \(numberTitle[reloc]!)\(reportTitle[reportContent]!)"
        @unknown default:
            message = "Unknown Error"
        }
        
        let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://teams.microsoft.com/l/chat/0/0?users=\(email)&message=\(encodedMessage)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("teams앱 오류")
        }
    }
}
