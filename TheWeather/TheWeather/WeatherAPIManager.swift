//
//  WeatherAPIManager.swift
//  TheWeather
//
//  Created by Damir Nuriev on 26.12.2023.
//

import Foundation
import RxSwift
import RxCocoa

class WeatherAPIManager {
    static func fetchWeatherDataForCity(for city: String) -> Observable<WeatherData> {
        let apiKey = "65e995f500d385bb3495fc7fc82f9bbe"
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&cnt=25&appid=\(apiKey)&units=metric&lang=ru"
        
        guard let url = URL(string: apiUrl) else {
            return Observable.error(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data in
                let decoder = JSONDecoder()
                return try decoder.decode(WeatherData.self, from: data)
            }
            .asObservable()
            .catch { error in
                return Observable.error(error)
            }
            .do(onNext: { weatherData in
                WeatherViewModel.shared.updateUI(with: weatherData)
            })
    }
    
    static func fetchWeatherDataForLocation(for location: Location) -> Observable<WeatherData> {
        let apiKey = "65e995f500d385bb3495fc7fc82f9bbe"
        let apiUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.latitude)&lon=\(location.longitude)&cnt=25&appid=\(apiKey)&units=metric&lang=ru"
        
        guard let url = URL(string: apiUrl) else {
            return Observable.error(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data in
                let decoder = JSONDecoder()
                return try decoder.decode(WeatherData.self, from: data)
            }
            .asObservable()
            .catch { error in
                return Observable.error(error)
            }
            .do(onNext: { weatherData in
                WeatherViewModel.shared.updateUI(with: weatherData)
            })
    }
}
