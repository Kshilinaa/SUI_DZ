//
//  Cell.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 06.05.2024.
//
import SwiftUI
/// Экран с VPN (Первый экран)
struct VpnView: View {
    private enum Constant {
        static let ipAddressText = "IP Address"
        static let receivedText = "Received"
        static let sentText = "Sent"
        static let ipAddress = "127.0.0.1"
        static let zero = "0 MB"
        static let serviceExpiration = "Service will expire after 15 days."
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .top)
            VStack(spacing: 53) {
                VStack(alignment: .center, spacing: 45) {
                    Image(.flagCountry)
                    Toggle(isOn: $isOnToggle, label: {}).frame(width: 50)
                        .tint(.green)
                }
                HStack(spacing: 30) {
                    makeGroup(alignment: .leading, spacing: 14, weight: .regular, firstText: Constant.ipAddressText, secondText: Constant.receivedText, thridText: Constant.sentText)
                    
                    makeGroup(alignment: .trailing, spacing: 14, weight: .bold, firstText: Constant.ipAddress, secondText: Constant.zero, thridText: Constant.zero)
                }
                Spacer()
                bottomTextView
            }.frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 80)
                .padding(.bottom, 29)
        }
    }
    
    private var bottomTextView: some View {
        Text(Constant.serviceExpiration)
            .foregroundStyle(.white)
            .font(.system(size: 18, weight: .regular))
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 48)
    }
    
    @State private var isOnToggle = false
    
    private func makeGroup(alignment: HorizontalAlignment, spacing: CGFloat, weight: Font.Weight,
                           firstText: String, secondText: String, thridText: String) -> some View {
        VStack(alignment: alignment, spacing: spacing) {
            Group {
                Text(firstText)
                Text(secondText)
                Text(thridText)
            }
            .foregroundStyle(.white)
            .font(.system(size: 18, weight: weight))
        }
    }
}

