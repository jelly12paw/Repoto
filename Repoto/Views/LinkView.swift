//
//  LinkView.swift
//  Repoto
//
//  Created by Haejin Park on 1/22/25.
//

import SwiftUI

struct LinkView: View {
    @EnvironmentObject var manager: ReportManager
    @State private var selectedContent: String?
    
    let loc = UserDefaults.standard.integer(forKey: "loc")
    let reloc = UserDefaults.standard.integer(forKey: "reloc")
        
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HeaderView(loc: loc, reloc: reloc)
                    .padding(.bottom, 20)
                
                Image("toilet_\(reloc)")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                    .padding(.horizontal, 16)
                    .padding(.leading, -16)
                
                ReportContentButtonsView(reloc: reloc, selectedContent: $selectedContent)
                
                Spacer()
                Spacer()
                
                ReportButtonView(selectedContent: $selectedContent, loc: loc, reloc: reloc)
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
    let loc: Int?
    let reloc: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(locationTitle[loc] ?? "")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 18, weight: .semibold))
                .padding(.vertical, 10)
            
            Divider()
                .foregroundStyle(.gray)
                .padding(.leading, -16)
                .padding(.bottom, 16)
            
            Text("신고 위치 : \(numberTitle[reloc!] ?? "")")
                .font(.system(size: 22, weight: .bold))
                .padding(.bottom, 10)
            
            Text("신고하는 위치가 올바른지 확인해주세요")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.gray)
        }
    }
}

private struct ReportContentButtonsView: View {
    @EnvironmentObject var manager: ReportManager
    
    let reloc: Int
    
    @Binding var selectedContent: String?
    
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
                    if validNumbers.contains(reloc) {
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
    @Binding var selectedContent: String?
    @State private var isPresented: Bool = false
    
    let loc: Int?
    let reloc: Int
    
    private var isButtonEnabled: Bool {
        guard manager.reportContent != nil else { return false }
        
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
            .sheet(isPresented: $isPresented) {
                MailCompose()
                    .environmentObject(manager)
            }
        }
    }
}

#Preview {
    LinkView()
        .environmentObject(ReportManager())
}
