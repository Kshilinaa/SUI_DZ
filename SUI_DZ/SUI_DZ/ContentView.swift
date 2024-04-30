//
//  ContentView.swift
//  SUI_DZ

import SwiftUI

struct ContentView: View {
    @State var isErorr = false
    @State var isSecondError = false
    @State var isFirhdErorr = false
    @State var isFourthError = false
    @State var alertMessage = "Нажмите на кнопку"
    @State var actionSheetMessage = "Нажмите на кнопку"
    let randomMessages = ["RMLove", "Промокод на 50 приседаний", "Отдыхай"]
    
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
                        self.isErorr = true
                    }) {
                        Text("Показать")
                            .frame(width: 150, height: 48)
                            .background(Color("purpleColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }.alert(isPresented: $isErorr, content: {
                        Alert(title: Text("Тест"))
                    })
                    
                    Button(action: {
                        self.isSecondError = true
                    }) {
                        Text("Показать")
                            .frame(width: 150, height: 48)
                            .background(Color("purpleColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }.alert(isPresented: $isSecondError, content: {
                        Alert(title: Text(alertMessage),
                              primaryButton: .default(Text("Кнопка 1"), action: {
                                  alertMessage = "Последний раз нажимали на кнопку 1"
                              }),
                              secondaryButton: .destructive(Text("Кнопка 2"), action: {
                                  alertMessage = "Последний раз нажимали на кнопку 2"
                              }))
                    })
                    Button(action: {
                        self.isFirhdErorr = true
                    }) {
                        Text("Показать")
                            .frame(width: 150, height: 48)
                            .background(Color("purpleColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }.actionSheet(isPresented: $isFirhdErorr, content: {
                        ActionSheet(title: Text("Это ActionSheet с 1 кнопкой"))
                    })
                    
                    Button(action: {
                        self.isFourthError = true
                    }) {
                        Text("Показать")
                            .frame(width: 150, height: 48)
                            .background(Color("purpleColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }.actionSheet(isPresented: $isFourthError, content: {
                        ActionSheet(title: Text(actionSheetMessage), buttons: [
                            .default(Text("Нажми и получи послание на день"), action: {
                                actionSheetMessage = randomMessages.randomElement() ?? "Ошибка"
                            })
                        ])
                    })
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
