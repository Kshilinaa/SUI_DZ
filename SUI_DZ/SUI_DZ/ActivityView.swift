//
//  ActivityView.swift
//  SUI_DZ
import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    /// Определение типа UIViewControllerType для структуры ActivityView
    typealias UIViewControllerType = UIActivityViewController
    /// Массив элементов активности, которые будут отображаться в диалоговом окне активности
    public var activityItems: [Any]
    /// Массив пользовательских действий, которые будут доступны в диалоговом окне активности
    public var applicationActivities: [UIActivity]?
    /// Создание и настройка экземпляра UIActivityViewController
    func makeUIViewController(context: Context) -> UIActivityViewController {
    let viewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return viewController
    }
    /// Обновление контроллера представления при необходимости
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


