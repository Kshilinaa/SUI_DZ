//
//  ProductsView.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 05.05.2024.
//
import SwiftUI
/// Экран выбора  тарифов 
struct PurchaseView: View {
    private enum Constant {
        static let mainText = "Privacy Matters"
        static let additionalText = "Protect your online activities with VPN Plus"
        static let addedText = "Added"
        static let buyText = "Buy"
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                Color.black.ignoresSafeArea(edges: .top)
                topTextView
                packageView
            }.ignoresSafeArea(edges: .bottom)
        }.background(.black)
    }
    
    @State private var selectedIndexButton: Int? = nil
    @EnvironmentObject private var storage: VPNService
    
    private var topTextView: some View {
        VStack(spacing: 22) {
            Text(Constant.mainText)
                .foregroundStyle(.white)
                .font(.system(size: 24, weight: .regular))
            Text(Constant.additionalText)
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .regular))
            Spacer()
        }
    }
    
    private var packageView: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 50)
            ForEach(storage.vpnPackage.indices, id: \.self) { index in
                VStack {
                    ZStack {
                        Image(.calendar)
                        Text("\(storage.vpnPackage[index].numberDays)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(.black)
                            .offset(y: 12)
                    }
                    Text(storage.vpnPackage[index].packageName)
                        .foregroundStyle(.white)
                    Button(action: {
                        if self.selectedIndexButton == index {
                            self.selectedIndexButton = nil
                        } else {
                            self.selectedIndexButton = index
                        }
                        storage.index = selectedIndexButton
                    }, label: {
                        Text(selectedIndexButton == index ? Constant.addedText : Constant.buyText)
                            .padding()
                            .foregroundStyle(.white)
                            .frame(maxWidth: 100, maxHeight: .infinity)
                            .background(selectedIndexButton == index ? Color(red: 68 / 255.0, green: 215 / 255.0, blue: 182 / 255.0) : .blue)
                    })
                    .clipShape(.rect(cornerRadius: 8))
                }
            }
        }
    }
}



