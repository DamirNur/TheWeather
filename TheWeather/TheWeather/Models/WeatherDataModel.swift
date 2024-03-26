//
//  WeatherDataModel.swift
//  TheWeather
//
//  Created by Damir Nuriev on 22.03.2024.
//

import Foundation

struct WeatherDataModel {
    let cityName: String?
    let temperature: Double?
    let weatherDescription: String?
    let firstDate: String?
    let firstTemperature: Double?
    let firstDescription: String?
    let secondDate: String?
    let secondTemperature: Double?
    let secondDescription: String?
    let thirdDate: String?
    let thirdTemperature: Double?
    let thirdDescription: String?
    
    init(weatherData: WeatherData) {
        self.cityName = weatherData.city.name
        self.temperature = weatherData.list.first?.main.temp
        self.weatherDescription = weatherData.list.first?.weather.first?.description
        self.firstDate = weatherData.list[Constants.firstIndex].dtTxt
        self.firstTemperature = weatherData.list[Constants.firstIndex].main.temp
        self.firstDescription = weatherData.list[Constants.firstIndex].weather.first?.description
        self.secondDate = weatherData.list[Constants.secondIndex].dtTxt
        self.secondTemperature = weatherData.list[Constants.secondIndex].main.temp
        self.secondDescription = weatherData.list[Constants.secondIndex].weather.first?.description
        self.thirdDate = weatherData.list[Constants.thirdIndex].dtTxt
        self.thirdTemperature = weatherData.list[Constants.thirdIndex].main.temp
        self.thirdDescription = weatherData.list[Constants.thirdIndex].weather.first?.description
    }
}
