//
//  PurchaseItemView.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 05.05.2024.
//
import SwiftUI

struct PurchaseItemView: View {
    private enum Constant {
        static let buttonNameText = "Buy"
    }
    let day: Int
    let text: String
    let closureActionButton: () -> ()
    
    var body: some View {
        VStack {
            packageView
            buttonView
            Spacer()
        }
    }
    private var packageView: some View {
        HStack() {
            ZStack {
                Image(.calendar)
                Text("\(day)")
                    .font(.system(size: 36, weight: .bold))
                    .offset(y: 12)
                    .foregroundStyle(.black)
            }
            Text("\(text)")
                .foregroundStyle(.white)
            Spacer()
        }
    }
    private var buttonView: some View {
        Button(action: {
            closureActionButton()
        }, label: {
            Text(Constant.buttonNameText)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .padding(.horizontal, 24)
            
        }).background(.blue)
            .clipShape(.rect(cornerRadius: 8))
    }
}
