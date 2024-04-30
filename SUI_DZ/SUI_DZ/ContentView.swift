//
//  ContentView.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State var isOntoggle = false
    @State var isReplenish = false
    @State var istransfer = false
    @State var isOpenCard = false
    @State var balance: Double = 50000
    @State var balance2: Double = 100000
    @State var balance3: Double = 1000
    @State var transferAmount: Double = 1000
    @State var selectedCardIndex: Int? = nil
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    VStack(alignment: .leading) {
                        Button {
                            isOntoggle.toggle()
                        } label: {
                            Image("cardIcon")
                            VStack {
                                Text("\(String(format: "%.2f", balance)) ₽")
                                    .bold()
                                    .tint(.black)
                                
                                Text("MIR  **0001")
                                    .tint(.black)
                            }
                        }
                        Divider()
                        Button {
                            isOntoggle.toggle()
                        } label: {
                            Image("cardIcon")
                            VStack {
                                Text("\(String(format: "%.2f", balance2)) ₽")
                                    .bold()
                                    .tint(.black)
                                Text("MIR  **0002")
                                    .tint(.black)
                            }
                        }
                        Divider()
                        Button {
                            isOntoggle.toggle()
                        } label: {
                            Image("cardIcon")
                            VStack {
                                Text("\(String(format: "%.2f", balance3)) ₽")
                                    .bold()
                                    .tint(.black)
                                
                                Text("MIR  **0003")
                                    .tint(.black)
                            }
                        }
                        Divider()
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                
                ZStack {
                    Rectangle()
                        .fill(Color("backgroundColor"))
                        .overlay(
                            Text("Карта 1")
                                .fontWeight(.heavy)
                                .padding(.top, 30)
                                .padding(), alignment: .topLeading
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("cardColor"))
                                .overlay(Text("\(String(format: "%.2f", balance)) ₽")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                                    .fontWeight(.heavy)
                                    .padding(), alignment: .topLeading)
                                .overlay(Text("Доступно")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(uiColor: .systemGray4))
                                    .padding()
                                    .padding(.top, 25), alignment: .topLeading)
                                .overlay(Image("mirLogo")
                                    .padding(), alignment: .bottomTrailing)
                                .frame(width: 360, height: 200)
                                .padding(.horizontal)
                                .padding(.top, 100),
                            alignment: .top
                        )
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .frame(width: 358, height: 88)
                            .shadow(radius: 2, y: 3)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                balance += 1000
                                isReplenish = true
                            }) {
                                VStack(spacing: 15) {
                                    Image("firstIcon")
                                    Text("Пополнить")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Button(action: {
                                selectedCardIndex = 0
                                istransfer = true
                            }) {
                                VStack(spacing: 15) {
                                    Image("secondIcon")
                                    Text("Перевести")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Button(action: {
                            }) {
                                VStack(spacing: 10) {
                                    Image("creditIcon")
                                        .padding(.top, 10)
                                    Text("Открыть\nкарту")
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
                .offset(x: isOntoggle ? 300 : 0)
            }
            .actionSheet(isPresented: $isReplenish) {
                ActionSheet(title: Text("Баланс успешно пополнен"), message: nil, buttons: [.default(Text("OK"))])
            }
            
            Toggle(isOn: $isOntoggle, label: { Text("Показать мой кошелек")
                    .bold()
            })
            .padding(.horizontal)
        }
        .alert(isPresented: $istransfer) {
            Alert(title: Text("Перевод"), message: Text("Перевести 1000 ₽ на карту?"), primaryButton: .default(Text("Ок")) {
                if let selectedCardIndex = selectedCardIndex {
                                    switch selectedCardIndex {
                                    case 0:
                                        balance -= transferAmount
                                        balance2 += transferAmount
                                    default:
                                        break
                                    }
                                }
                            }, secondaryButton: .cancel())
                        }
                    }
                }
                
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
