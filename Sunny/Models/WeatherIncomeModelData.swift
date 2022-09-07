//
//  WeatherIncomeModelData.swift
//  Sunny
//
//  Created by Павел Афанасьев on 07.09.2022.
//


import Foundation

// MARK: - Weather
struct WeatherIncomeModelData: Codable {
    let weather: [WeatherElement]
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike: Double
    
    // Перечисление для изменения значения ключа 
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
}
