//
//  ContentView.swift
//  SUI_DZ

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack  {
            Text("Alert & ActionSheet")
                .font(.system(size: 25, weight: .bold))
                .fontWeight(.bold)
                .padding(30)
            
            HStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 25) {
                    Text("Пример Alert")
                        .frame(width: 150, height: 48, alignment: .leading)
                        .font(.headline.bold())
                    Text("Пример Alert с 2\n кнопками логикой")
                        .frame(width: 160, height: 48, alignment: .leading)
                        .font(.headline.bold())
                    Text("Пример ActionSheet")
                        .frame(width: 150, height: 48, alignment: .leading)
                        .font(.headline.bold())
                    Text("Пример ActionSheet кнопками и логикой")
                        .frame(width: 169, height: 48, alignment: .leading)
                        .font(.headline.bold())
                    Spacer()
                }
                
                
                VStack(spacing: 25) {
                    Button(action: {
                        print("Показать Alert 1")
                    }) {
                        Text("Показать")
                            .frame(width: 150, height: 48)
                            .background(Color("PurpleColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        print("Показать Alert 2")
                    }) {
                        Text("Показать")
                            .frame(width: 150, height: 48)
                            .background(Color("PurpleColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        print("Показать ActionSheet 1")
                    }) {
                        Text("Показать")
                            .frame(width: 150, height: 48)
                            .background(Color("PurpleColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        print("Показать ActionSheet 2")
                    }) {
                        Text("Показать")
                            .frame(width: 150, height: 48)
                            .background(Color("PurpleColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    Spacer()
                }
            }
            .padding(20)
        }
    }
struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
