//
//  MessageCompose.swift
//  Repoto
//
//  Created by Haejin Park on 1/21/25.
//

import SwiftUI
import MessageUI

//struct MessageCompose: UIViewControllerRepresentable {
//    @EnvironmentObject var manager: ReportManager
//    @Environment(\.presentationMode) var presentationMode
//    
//    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
//        let composeViewController = MFMessageComposeViewController()
//        composeViewController.messageComposeDelegate = context.coordinator
//        composeViewController.recipients = ["jelly09@pos.idserve.net"]
//        
//        var bodyText: String
//        
//        switch manager.source {
//        case .inApp:
//            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
//        case .link:
//            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
//        @unknown default:
//            bodyText = "Unknown Error"
//        }
//        
//        composeViewController.body = bodyText
//        return composeViewController
//    }
//    
//    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) { }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
//        var parent: MessageCompose
//        
//        init(_ parent: MessageCompose) {
//            self.parent = parent
//        }
//        
//        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
//            switch result {
//            case .cancelled:
//                print("Cancelled")
//            case .sent:
//                print("Sent message:", controller.body ?? "")
//            case .failed:
//                print("Failed")
//            @unknown default:
//                print("Unknown Error")
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
//
//struct MailCompose: UIViewControllerRepresentable {
//    @EnvironmentObject var manager: ReportManager
//    @Environment(\.presentationMode) var presentationMode
//
//    func makeUIViewController(context: Context) -> MFMailComposeViewController {
//        let mailComposeVC = MFMailComposeViewController()
//        mailComposeVC.mailComposeDelegate = context.coordinator
//        mailComposeVC.setToRecipients(["jelly09@postech.ac.kr"])
//
//        let bodyText: String
//
//        switch manager.source {
//        case .inApp:
//            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
//        case .link:
//            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.loc]!) \(numberTitle[manager.reloc]!)\(reportTitle[manager.reportContent]!)"
//        @unknown default:
//            bodyText = "Unknown Content"
//        }
//
//        mailComposeVC.setSubject(bodyText)
//        mailComposeVC.setMessageBody(bodyText, isHTML: false)
//
//        return mailComposeVC
//    }
//
//    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//        var parent: MailCompose
//
//        init(parent: MailCompose) {
//            self.parent = parent
//        }
//
//        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}

//struct MailCompose: UIViewControllerRepresentable {
//    @EnvironmentObject var manager: ReportManager
//    @Environment(\.presentationMode) var presentationMode
//
//    func makeUIViewController(context: Context) -> MFMailComposeViewController {
//        let mailComposeVC = MFMailComposeViewController()
//        mailComposeVC.mailComposeDelegate = context.coordinator
//        mailComposeVC.setToRecipients(["jelly09@postech.ac.kr"])
//
//        let bodyText: String
//
//        switch manager.source {
//        case .inApp:
//            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
//        case .link:
//            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.loc]!) \(numberTitle[manager.reloc]!)\(reportTitle[manager.reportContent]!)"
//        @unknown default:
//            bodyText = "Unknown Content"
//        }
//
//        mailComposeVC.setSubject(bodyText)
//        mailComposeVC.setMessageBody(bodyText, isHTML: false)
//
//        return mailComposeVC
//    }
//
//    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//        var parent: MailCompose
//
//        init(parent: MailCompose) {
//            self.parent = parent
//        }
//
//        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//            parent.presentationMode.wrappedValue.dismiss()
//
//            // 신고 완료 알림 표시 및 앱 종료
//            if result == .sent {
//                DispatchQueue.main.async {
//                    self.parent.manager.presentExitAlert()
//                }
//            }
//        }
//    }
//}

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
            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.loc]!) \(numberTitle[manager.reloc]!)\(reportTitle[manager.reportContent]!)"
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
            
            if result == .sent {
                DispatchQueue.main.async {
                    self.parent.manager.didReturnFromMail = true
                    self.parent.manager.isShowingAlert = true

                }
            }
        }
    }
}

//import UserNotifications
//
//struct MailCompose: UIViewControllerRepresentable {
//    @EnvironmentObject var manager: ReportManager
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var didReturnFromMail: Bool // 메일 시트 닫힘 여부를 전달
//
//    func makeUIViewController(context: Context) -> MFMailComposeViewController {
//        let mailComposeVC = MFMailComposeViewController()
//        mailComposeVC.mailComposeDelegate = context.coordinator
//        mailComposeVC.setToRecipients(["jelly09@postech.ac.kr"])
//        
//        let bodyText: String
//        
//        switch manager.source {
//        case .inApp:
//            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.selectedLocation!]!) \(numberTitle[manager.selectedNumber]!)\(reportTitle[manager.reportContent]!)"
//        case .link:
//            bodyText = "\(reportIcon[manager.reportContent]!) \(locationTitle[manager.loc]!) \(numberTitle[manager.reloc]!)\(reportTitle[manager.reportContent]!)"
//        @unknown default:
//            bodyText = "Unknown Content"
//        }
//        
//        mailComposeVC.setSubject(bodyText)
//        mailComposeVC.setMessageBody(bodyText, isHTML: false)
//        
//        return mailComposeVC
//    }
//    
//    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//        var parent: MailCompose
//
//        init(parent: MailCompose) {
//            self.parent = parent
//        }
//
//        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
////            @EnvironmentObject var manager: ReportManager
//            parent.presentationMode.wrappedValue.dismiss()
//            
//            if result == .sent {
//                DispatchQueue.main.async {
//                    self.parent.didReturnFromMail = true
//                    
//                    self.triggerNotification() // 알림 트리거
//                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend)) // 앱 백그라운드로 전환
//                }
//            }
//        }
//        
//        // UserNotification 알림 트리거
//        private func triggerNotification() {
//            let notificationCenter = UNUserNotificationCenter.current()
//            
//            // 알림 권한 요청
//            notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
//                if granted {
//                    let content = UNMutableNotificationContent()
//                    content.title = "신고 완료"
//                    content.body = "신고가 접수되었습니다."
//                    content.sound = .default
//
//                    // 즉시 실행 트리거
//                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
//                    
//                    let request = UNNotificationRequest(
//                        identifier: UUID().uuidString,
//                        content: content,
//                        trigger: trigger
//                    )
//                    
//                    notificationCenter.add(request) { error in
//                        if let error = error {
//                            print("알림 등록 실패: \(error.localizedDescription)")
//                        }
//                    }
//                } else if let error = error {
//                    print("알림 권한 요청 실패: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//}
