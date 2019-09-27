//
//  WeatherGetter.swift
//  resmi
//
//  Created by Admin on 27.09.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct CurrentLocalWeather: Codable {
    let base: String
    let clouds: Clouds
    let cod: Int
    let coord: Coord
    let dt: Int
    let id: Int
    let main: Main
    let name: String
    let sys: Sys
    let visibility: Int
    let weather: [Weather]
    let wind: Wind
}
struct Clouds: Codable {
    let all: Int
}
struct Coord: Codable {
    let lat: Double
    let lon: Double
}
struct Main: Codable {
    let humidity: Int
    let pressure: Int
    let temp: Double
    let tempMax: Double
    let tempMin: Double
    private enum CodingKeys: String, CodingKey {
        case humidity, pressure, temp, tempMax = "temp_max", tempMin = "temp_min"
    }
}
struct Sys: Codable {
    let country: String
    let id: Int
    let message: Double
    let sunrise: UInt64
    let sunset: UInt64
    let type: Int
}
struct Weather: Codable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}
struct Wind: Codable {
    let speed: Double
}

protocol WeatherGetterDelegate {
    func didGetWeather(weather: CurrentLocalWeather)
}

class WeatherGetter {
    
    private var delegate: WeatherGetterDelegate
    
    private let openWeatherMapBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "cadfc8773981cf5929590bff97553e3d"
    
    init(delegate: WeatherGetterDelegate) {
        self.delegate = delegate
    }
    
    func getWeather(city: String) {
        
        let session = URLSession.shared
        
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
        let dataTask = session.dataTask(with: weatherRequestURL) { (data, response, err) in
            if let error = err {
                print("Error:\n\(error)")
            }
            else {
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                let weatherData = Data((dataString?.utf8)!)
                let decoder = JSONDecoder()
                
                do {
                    let currentLocalWeather = try decoder.decode(CurrentLocalWeather.self, from: weatherData)
                    self.delegate.didGetWeather(weather: currentLocalWeather)
                    print(currentLocalWeather.main.temp)
                } catch {
                    print(error)
                }
                
            }
        }

        dataTask.resume()
        
    }
    
}
