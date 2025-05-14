//
//  ReportView.swift
//  Repoto
//
//  Created by Haejin Park on 1/17/25.
//

import SwiftUI

struct ReportView: View {
    @EnvironmentObject var manager: ReportManager
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HeaderView()
                    .padding(.bottom, 20)
                
                ToiletMapView()
                    .padding(.leading, -16)
                
                ReportContentButtonsView()
                
                Spacer()
                Spacer()
                
                ReportButtonView()
                    .padding(.leading, -16)
                
                Spacer()
            }
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            GeometryReader { geometry in
                if manager.isShowingAlert {
                    ExitAlertView()
                        .frame(height: geometry.size.height * 1.2)
                        .padding(.top, -geometry.size.height * 0.15)
                }
            }
        }
    }
}

private struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
                .foregroundStyle(.gray)
                .padding(.leading, -16)
                .padding(.bottom, 16)
            
            Text("위치")
                .font(.system(size: 22, weight: .bold))
                .padding(.bottom, 10)
            
            Text("신고하는 위치에 해당하는 번호를 선택해주세요")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.gray)
        }
    }
}

private struct ReportContentButtonsView: View {
    @EnvironmentObject var manager: ReportManager
    
    private let reportContentData: [(id: String, defaultImage: String, selectedImage: String, validNumbers: [Int])] = [
        ("washbasinclogged", "washbasinclogged_lightgray", "washbasinclogged_blue", [0, 1, 2]),
        ("toiletclogged", "toiletclogged_lightgray", "toiletclogged_blue", [3, 4, 5]),
        ("toiletpaper", "toiletpaper_lightgray", "toiletpaper_blue", [0, 1, 2, 3, 4, 5]),
        ("sos", "sos_lightgray", "sos_blue", [0, 1, 2, 3, 4, 5])
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("신고 내용")
                .font(.system(size: 22, weight: .bold))
                .padding(.bottom, 10)
                .padding(.top, 40)
            
            HStack {
                ForEach(reportContentData, id: \.id) { (id, defaultImage, selectedImage, validNumbers) in
                    if validNumbers.contains(manager.selectedNumber) {
                        Button(action: {
                            manager.reportContent = id
                        }) {
                            Image(manager.reportContent == id ? selectedImage : defaultImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width * 0.3)
                        }
                    }
                }
            }
            .padding(.trailing, 16)
        }
    }
}

private struct ReportButtonView: View {
    @EnvironmentObject var manager: ReportManager
    
    @State private var isPresented = false
    
    private var isButtonEnabled: Bool {
        guard let reportContent = manager.reportContent else { return false }
        
        if manager.selectedNumber == 0 { return false }
        if manager.selectedNumber <= 2 && reportContent == "toiletclogged" { return false }
        if manager.selectedNumber > 2 && reportContent == "washbasinclogged" { return false }
        
        return true
    }
    
    private var buttonColor: Color {
        isButtonEnabled ? Color.blue : Color.lightgray
    }
    
    private var teamsButtonColor: Color {
        isButtonEnabled ? Color.indigo : Color.lightgray
    }
    
    var body: some View {
        HStack {
            Button(action: {
                manager.openTeamsChat()
            }) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(teamsButtonColor)
                    .frame(height: 60)
                    .overlay(
                        Text("Teams로 신고하기")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                    )
                    .padding(.leading, 16)
            }
            .disabled(!isButtonEnabled)
            
            Button(action: {
                isPresented = true
            }) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(buttonColor)
                    .frame(height: 60)
                    .overlay(
                        Text("메일로 신고하기")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                    )
                    .padding(.trailing, 16)
            }
            .disabled(!isButtonEnabled)
        }
        .sheet(isPresented: $isPresented) {
            MailCompose()
                .environmentObject(manager)
        }
    }
}


#Preview {
    ReportView()
        .environmentObject(ReportManager())
}
