//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by Павел Афанасьев on 06.09.2022.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum requestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    // Передаем модель во ViewController с использование замыкания
    var onCompletion: ((WeatherIncomeModel) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: requestType){
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
        
    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            if let jsonData = data {
                // Создаем объект на основе спарсенных данных из JSON, приведенный к нашей модели для обновления интерфейса
                if let weatherIncomeModel = self.parseJSON(withData: jsonData) {
                    self.onCompletion?(weatherIncomeModel)
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data) -> WeatherIncomeModel?{
        let decoder = JSONDecoder()
        do {
            let WeatherIncomeModelData = try decoder.decode(WeatherIncomeModelData.self, from: data)
            guard let WeatherIncomeModel = WeatherIncomeModel(weatherIncomeModelData: WeatherIncomeModelData) else { return nil }
            return WeatherIncomeModel
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
