//
//  VPNService.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 05.05.2024.

import SwiftUI
/// Сервис для управления пакетами VPN
class VPNService: ObservableObject {
    
    @Published var index: Int?
    /// Доступные пакеты VPN.
    var vpnPackage: [VPNPackageModel ] = [
        .init(numberDays: 7, packageName: "Vacation (7 days) 99 RUB", image: .calendar),
        .init(numberDays: 30, packageName: "Standart (1 month) 179 RUB", image: .calendar),
        .init(numberDays: 90, packageName: "Standart+ (3 month) 279 RUB", image: .calendar)
    ]
}

