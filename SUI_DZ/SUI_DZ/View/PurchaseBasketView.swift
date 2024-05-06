//
//  PurchaseBasketView.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 05.05.2024.
//

import SwiftUI
/// Экран  корзины покупок
struct PurchaseBasketView: View {
    private enum Constant {
        static let defaultBasketText = "Your shopping cart is empty!"
        static let choosedText = "You choosed"
        static let warningText = "Please check and pay the selected tariff"
        static let alertText = "Покупка оформлена успешно"
        static let okText = "OK"
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .top)
            VStack(spacing: 22) {
                Text(Constant.choosedText)
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .regular))
                Text(Constant.warningText)
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .regular))
                Spacer()
                basketCellView
            }
        }
    }
    
    @EnvironmentObject private var purchaseViewModel: VPNService
    @State private var showAlert = false
    
    private var basketCellView: some View {
        VStack {
            if let index = purchaseViewModel.index {
                PurchaseItemView(day: purchaseViewModel.vpnPackage[index].numberDays, text: purchaseViewModel.vpnPackage[index].packageName) {
                    showAlert = true
                }.padding()
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(Constant.alertText), message: Text("\(purchaseViewModel.vpnPackage[index].packageName)"), dismissButton: .default(Text(Constant.okText)))
                    }
            } else {
                Text(Constant.defaultBasketText)
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .regular))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
