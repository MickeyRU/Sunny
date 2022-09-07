//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by Павел Афанасьев on 06.09.2022.
//

import Foundation

struct NetworkWeatherManager {
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, responce, error in
            if let jsonData = data {
                self.parseJSON(withData: jsonData)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data){
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherIncomeModelData.self, from: data)
            print(weather.main.temp)
        } catch let error as NSError {
          print(error.localizedDescription)
        }
    }
    
}
