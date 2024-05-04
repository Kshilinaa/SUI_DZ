//
//  CarsModel.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 03.05.2024.
//

import Foundation
/// Структура CarsModel, представляющая модель автомобиля
struct CarsModel: Hashable {
/// Путь к изображению автомобиля
let carImage: String
/// Тип двигателя автомобиля
let engine: String
/// Тип трансмиссии автомобиля
let transmission: String
/// Модель автомобиля
let model: String
/// Цена автомобиля
let price: Int
}

