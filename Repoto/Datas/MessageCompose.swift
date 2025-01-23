//
//  MessageCompose.swift
//  Repoto
//
//  Created by Haejin Park on 1/21/25.
//

import SwiftUI
import MessageUI

struct MessageCompose: UIViewControllerRepresentable {
    @EnvironmentObject var manager: ReportManager
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composeViewController = MFMessageComposeViewController()
        composeViewController.messageComposeDelegate = context.coordinator
        composeViewController.recipients = ["jelly09@pos.idserve.net"]
        
        var bodyText: String
        
        switch manager.source {
        case .inApp:
            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
        case .link:
            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
        @unknown default:
            bodyText = "Unknown Error"
        }
        
        composeViewController.body = bodyText
        return composeViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageCompose
        
        init(_ parent: MessageCompose) {
            self.parent = parent
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            switch result {
            case .cancelled:
                print("Cancelled")
            case .sent:
                print("Sent message:", controller.body ?? "")
            case .failed:
                print("Failed")
            @unknown default:
                print("Unknown Error")
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct MailCompose: UIViewControllerRepresentable {
    @EnvironmentObject var manager: ReportManager
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = context.coordinator
        mailComposeVC.setToRecipients(["jelly09@postech.ac.kr"])
        
        let bodyText: String
        
        switch manager.source {
        case .inApp:
            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
        case .link:
            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
        @unknown default:
            bodyText = "Unknown Content"
        }
        
        mailComposeVC.setSubject(bodyText)
        mailComposeVC.setMessageBody(bodyText, isHTML: false)
        
        return mailComposeVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailCompose
        
        init(parent: MailCompose) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
