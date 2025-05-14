//
//  ExitAlertView.swift
//  Repoto
//
//  Created by Haejin Park on 1/31/25.
//

import SwiftUI

struct ExitAlertView: View {
    @EnvironmentObject var manager: ReportManager
    
    private var route: String {
        manager.didReturnFromMail ? "메일" : "Teams"
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.15)
                .shadow(radius: 10)
                .overlay(
                    VStack(alignment: .center) {
                        
                        Spacer()
                        
                        Text("\(route)로 신고 접수하셨나요?")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.vertical, UIScreen.main.bounds.height * 0.02)
                        
                        Spacer()
                        
                        Divider()
                        
                        HStack {
                            if manager.source == .inApp {
                                Spacer()
                                
                                Button(action: {
                                    resetAlert()
                                    manager.resetDatas()
                                }) {
                                    Text("재신고")
                                        .foregroundStyle(.black)
                                }
                                
                                Spacer()
                                
                                Divider()
                                
                                Spacer()
                                
                                Button(action: {
                                    resetAlert()
                                    manager.resetDatas()
                                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                                }) {
                                    Text("신고완료")
                                        .foregroundStyle(.blue)
                                        .bold()
                                }
                                
                                Spacer()
                                
                            } else {
                                Spacer()
                                
                                Button(action: {
                                    resetAlert()
                                    manager.reportContent = nil
                                }) {
                                    Text("재신고")
                                        .foregroundStyle(.black)
                                }
                                
                                Spacer()
                                
                                Divider()
                                
                                Spacer()
                                
                                Button(action: {
                                    resetAlert()
                                    manager.reportContent = nil
                                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                                }) {
                                    Text("신고완료")
                                        .foregroundStyle(.blue)
                                        .bold()
                                }
                                
                                Spacer()
                            }
                        }
                    }
                )
            
            Spacer()
        }
    }
    
    private func resetAlert() {
        manager.isShowingAlert = false
        manager.didReturnFromMail = false
        manager.didReturnFromTeams = false
    }
}

#Preview {
    ExitAlertView()
        .environmentObject(ReportManager())
}
