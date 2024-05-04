//
//  ContentView.swift
//  SUI_DZ
//
import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var carViewModel = CarsViewModel()
    @State private var isToggleOn = false
    @State private var isOrderActionSheet = false
    @State private var isCascoAlertOn = false
    @State private var isShareOn = false
    @State private var alertCall = false
    @State private var isShareActivityPresented = false
    @State private var price = 2189900
    @State private var setCar = 0
    @State private var segmentedIndex = 0
    @State private var offSetX = 0
    @State private var progress: Float = 0
  
    
    var carBrand = ["C5", "S5", "S5 GT"]
    var cars = ["omodaC5", "omodaS5", "omodaS5GT"]
    private var carEquipment = ["Joy", "Lifestyle", "Ultimate", "Active","Supreme"]
    
    private enum Constant {
        static let thanksText = "Благодарим за заказ. Наш менеджер свяжется с Вами в рабочее время для уточнения деталей."
        static let infoText = "Информация об автомобиле"
        static let engine = "Двигатель"
        static let engineValue = "1.6 Тurbo"
        static let transmission = "Привод"
        static let noLabel = "Нет, не нужно"
        static let yesLabel = "Да"
        static let price = "Цена"
        static let order = "Заказать"
        static let transmissionValue = "AWD"
        static let equipment = "Kомплектация"
        static let casco = "ОМОДА Каско"
        static let cascoLabel = "Подключить Каско на выгодных условиях?"
       
    }
    
    var body: some View {
        ZStack{
            Color("backrgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image(.omodaLogo)
                        .padding(.leading, 130)
                    Spacer()
                    Button(action: {
                        isShareOn.toggle()
                    }, label: {
                        Image(.share)
                    })
                    .sheet(isPresented: $isShareOn, content: {
                        let transmission = carViewModel.getCurrentCar(index: segmentedIndex).transmission
                        let engine = carViewModel.getCurrentCar(index: segmentedIndex).engine
                        
                        ActivityView(activityItems: ["OMODA \(transmission) \(engine) всего за \(price) руб"])
                    })
                }
                .padding()
                Image(cars[segmentedIndex])
                    .frame(width: 200, height: 200)
                    .offset(x: CGFloat(offSetX))
                    .animation(.spring)
                
                Picker(selection: Binding(get: {
                    segmentedIndex
                }, set: { newValue in
                    segmentedIndex = newValue
                    offSetX = -500
                    moveBack()
                }), label: Text("")) {
                    ForEach(0..<carViewModel.cars.count) {
                        Text(carViewModel.cars[$0].model).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onChange(of: segmentedIndex) {newValue in
                    isToggleOn = false
                    price = carViewModel.cars[newValue].price
                }
                .padding()
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16.0, style: .circular)
                        .foregroundStyle(.white)
                        .frame(maxWidth: 400, maxHeight: 600)
                        .ignoresSafeArea()
                    VStack {
                        Text(Constant.infoText)
                            .bold()
                            .font(.system(size: 18))

                        HStack {
                            Text(Constant.engine)
                            Spacer()
                            Text(Constant.engineValue)
                            
                        }

                        Divider()
                            .frame(width: 250)
                            .padding(.bottom, 10)

                        HStack {
                            Text(Constant.transmission)
                            Spacer()
                            Text(Constant.transmissionValue)
                            
                        }

                        Divider()
                            .frame(width: 250)
                        
                        HStack {
                            Text(Constant.equipment)
                            Spacer()
                        }

                        VStack {
                            Slider(value: Binding(
                                get: { Double(setCar) },
                                set: { newValue in
                                    setNewCarPrice(
                                        oldPrice: setCar,
                                        value: Int(newValue)
                                    )
                                    setCar = Int(newValue)
                                }
                            ), in: 1...5, step: 1).tint(.black)

                            HStack(spacing: 30) {
                                ForEach(0..<carEquipment.count){ item in
                                    Text(carEquipment[item])
                                        .font(.system(size: 12))
                                }
                            }
                        }
                        
                        Toggle(isOn: $isToggleOn) {
                            Text(Constant.casco)
                        }
                        .alert(isPresented: $isToggleOn, content: {
                            Alert(title: Text(Constant.casco), message: Text(Constant.cascoLabel), primaryButton: .default(Text(Constant.noLabel), action: {
                            }), secondaryButton: .default(Text(Constant.yesLabel), action: {
                                price += 99000
                                isToggleOn = true
                            }))
                        })
                        .padding()
                        Divider()
                            .padding(.leading,70)
                            .padding(.trailing,70)
                            
                        HStack {
                            Text(Constant.price)
                                .bold()
                            Spacer()
                            Text("\(price) руб")
                                .bold()
                        }

                        VStack{
                            Button {
                                isOrderActionSheet.toggle()
                            } label: {
                                Text(Constant.order)
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 358, height: 48)
                            .background(Color("backrgroundColor"))
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 2, x: 0.0, y: 4.0)
                        }
                        .confirmationDialog("", isPresented: $isOrderActionSheet) {
                        } message: {
                            Text(Constant.thanksText)
                        }
                    }.padding()
                }
            }
        }
    }
    /// Анимация возврата изображения при смене модели автомобиля
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            offSetX = 0
        }
    }
    /// Установка новой цены автомобиля в зависимости от выбранной комплектации
    public func setNewCarPrice(oldPrice: Int, value: Int) {
        if oldPrice > value {
            price -= 190000
        } else if oldPrice < value {
            price += 190000
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
