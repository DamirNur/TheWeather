//
//  WeatherData.swift
//  TheWeather
//
//  Created by Damir Nuriev on 18.03.2024.
//

import Foundation

struct WeatherData: Codable {
    let list: [List]
    let city: City
}

struct City: Codable {
    let name: String
}

struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case dtTxt = "dt_txt"
    }
}

struct MainClass: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}

