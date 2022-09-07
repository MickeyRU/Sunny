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
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
    // Через инициализатор с возможность возвращения nil связываем модель данных для парсинга и модель для обновления интерфейса
    init?(weatherIncomeModelData: WeatherIncomeModelData) {
        cityName = weatherIncomeModelData.name
        temperature = weatherIncomeModelData.main.temp
        feelsLikeTemperature = weatherIncomeModelData.main.feelsLike
        conditionCode = weatherIncomeModelData.weather.first!.id
    }
}
