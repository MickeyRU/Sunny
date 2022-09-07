//
//  WeatherIncomeModel.swift
//  Sunny
//
//  Created by Павел Афанасьев on 07.09.2022.
//  Copyright © 2022 Ivan Akulov. All rights reserved.
//

import Foundation

struct WeatherIncomeModel {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        // Округляем целиком - т.е. 0 знаков после запятой
        return String(format: "%.0f", temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    // Через инициализатор с возможность возвращения nil связываем модель данных для парсинга и модель для обновления интерфейса
    init?(weatherIncomeModelData: WeatherIncomeModelData) {
        cityName = weatherIncomeModelData.name
        temperature = weatherIncomeModelData.main.temp
        feelsLikeTemperature = weatherIncomeModelData.main.feelsLike
        conditionCode = weatherIncomeModelData.weather.first!.id
    }
}
