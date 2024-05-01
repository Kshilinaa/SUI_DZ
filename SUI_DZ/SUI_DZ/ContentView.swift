//
//  ContentView.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    @State var airplaneMode = false
    @State var selectionWifi = 0
    @State var selectionBluetooth = 0
    @State var vpn = false
    var emptyState = [""]
    var wifiStates = ["Не подключено", "Подключено"]
    var bluetoothStates = ["Вкл.", "Выкл."]
    var modemStates = ["Выкл.", "Вкл."]
    


    var body: some View {
        NavigationView {
            VStack {
                Form {
                    if #available(iOS 16.0, *) {
                        Picker(selection: $selection, content: {
                            ForEach(0..<emptyState.count) {
                                Text(self.emptyState[$0])
                            }
                        }, label: {
                            profileBodyView
                        }).pickerStyle(.navigationLink)
                    }

                    if #available(iOS 16.0, *) {
                        Picker(selection: $selection, content: {
                            ForEach(0..<emptyState.count) {
                                Text(self.emptyState[$0])
                            }
                        }, label: {
                           offers
                        }).pickerStyle(.navigationLink)
                    }

                    Section {
                        if #available(iOS 16.0, *) {
                            Picker(selection: $selection, content: {
                                ForEach(0..<emptyState.count) {
                                    Text(self.emptyState[$0])
                                }
                            }, label: {
                                updatesIOS
                            }).pickerStyle(.navigationLink)
                        }
                    }

                    settingsView
                }.navigationBarTitle(Text("Настройки"))
            }
        }

    }

    private var settingsView: some View {
        Section {
            Toggle(isOn: $airplaneMode) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.orange)
                        Image(systemName: "airplane")
                            .foregroundColor(.white)
                    }
                    Text("Авиарежим")
                }
            }

            if #available(iOS 16.0, *) {
                Picker(selection: $selectionWifi, content: {
                    ForEach(0..<wifiStates.count) {
                        Text(self.wifiStates[$0])
                    }
                }, label: {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.blue)
                            Image(systemName: "wifi")
                                .foregroundColor(.white)
                        }
                        Text("Wi-Fi")
                    }
                }).pickerStyle(.navigationLink)
            }

            if #available(iOS 16.0, *) {
                Picker(selection: $selectionBluetooth, content: {
                    ForEach(0..<bluetoothStates.count) {
                        Text(self.bluetoothStates[$0])
                    }
                }, label: {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.blue)
                            Image("buetooth")
                                .foregroundColor(.white)
                        }
                        Text("Bluetooth")
                    }
                }).pickerStyle(.navigationLink)
            }

            if #available(iOS 16.0, *) {
                Picker(selection: $selection, content: {
                    ForEach(0..<emptyState.count) {
                        Text(self.emptyState[$0])
                    }
                }, label: {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.green)
                            Image("connection")
                                .foregroundColor(.white)
                        }
                        Text("Сотовая связь")
                    }
                }).pickerStyle(.navigationLink)
            }

            if #available(iOS 16.0, *) {
                Picker(selection: $selection, content: {
                    ForEach(0..<modemStates.count) {
                        Text(self.modemStates[$0])
                    }
                }, label: {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.green)
                            Image("modemImage")
                                .foregroundColor(.white)
                        }
                        Text("Режим модема")
                    }
                }).pickerStyle(.navigationLink)
            }

            Toggle(isOn: $vpn) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.blue)
                        Image(systemName: "network")
                            .foregroundColor(.white)
                    }
                    Text("VPN")
                }
            }
        }
    }

    private var profileBodyView: some View {
        HStack {
            Image("me")
                .resizable()
                .frame(width: 80, height: 100)
            VStack(alignment: .leading) {
                Text("Ksusha")
                    .font(.title2)
                    .bold()
                Text("Apple ID, iCloud, контент и покупки").font(.caption2)
            }
        }
    }

    private var offers: some View {
        HStack {
            Text("Предложения Apple ID")
            Spacer()
            ZStack {
                Circle()
                    .frame(height: 25)
                    .foregroundColor(.red)
                Text("3")
                    .foregroundColor(.white)
            }
        }
    }

    private var updatesIOS: some View {
        HStack {
            Text("IOS 17.2: уже доступно")
            Spacer()
            ZStack {
                Circle()
                    .frame(height: 25)
                    .foregroundColor(.red)
                Text("3")
                    .foregroundColor(.white)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
