//  ContentView.swift


import SwiftUI

struct MainTabView: View {
    private enum Constant {
        static let vpnTab = "VPN"
        static let purchaseTab = "Purchase"
        static let basketTab = "Basket"
    }
    var body: some View {
        TabView {
            VpnView()
                .tabItem {
                    Text(Constant.vpnTab)
                    Image("lock")
                }
            PurchaseView()
                .tabItem {
                    Text(Constant.purchaseTab)
                    Image("list")
                }
            PurchaseBasketView()
                .tabItem {
                    Text(Constant.basketTab)
                    Image("basket")
                }
        }.environmentObject(purchaseViewModel)
            .font(.headline)
            .tint(.blue)
            .onAppear() {
                UITabBar.appearance().backgroundColor = UIColor(resource: .barTint)
               // UITabBar.appearance().barTintColor = .barTint
                UITabBar.appearance().isTranslucent = false
            }
    }
    
    @ObservedObject private var purchaseViewModel = VPNService()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
