//
//  WeatherViewModel.swift
//  TheWeather
//
//  Created by Damir Nuriev on 26.12.2023.
//

import RxSwift
import RxCocoa

class WeatherViewModel {
    
    static let shared = WeatherViewModel()
    
    private let disposeBag = DisposeBag()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    let cityName = BehaviorRelay<String?>(value: nil)
    let temperature = BehaviorRelay<Double?>(value: nil)
    let weatherDescription = BehaviorRelay<String?>(value: nil)
    let firstDate = BehaviorRelay<String?>(value: nil)
    let firstTemperature = BehaviorRelay<Double?>(value: nil)
    let firstDescription = BehaviorRelay<String?>(value: nil)
    let secondDate = BehaviorRelay<String?>(value: nil)
    let secondTemperature = BehaviorRelay<Double?>(value: nil)
    let secondDescription = BehaviorRelay<String?>(value: nil)
    let thirdDate = BehaviorRelay<String?>(value: nil)
    let thirdTemperature = BehaviorRelay<Double?>(value: nil)
    let thirdDescription = BehaviorRelay<String?>(value: nil)
    
    let error = PublishRelay<String>()
    
    func updateUI(with weatherData: WeatherData) {
        cityName.accept(weatherData.city.name)
        temperature.accept(weatherData.list.first?.main.temp)
        weatherDescription.accept(weatherData.list.first?.weather.description)
        firstDate.accept(weatherData.list[8].dtTxt)
        firstTemperature.accept(weatherData.list[8].main.temp)
        firstDescription.accept(weatherData.list[8].weather.description)
        secondDate.accept(weatherData.list[16].dtTxt)
        secondTemperature.accept(weatherData.list[16].main.temp)
        secondDescription.accept(weatherData.list[16].weather.description)
        thirdDate.accept(weatherData.list[24].dtTxt)
        thirdTemperature.accept(weatherData.list[24].main.temp)
        thirdDescription.accept(weatherData.list[24].weather.description)
    }
    
    private func formatDate(_ dateString: String) -> String {
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM"
        return outputFormatter.string(from: date)
    }
    
    func fetchWeatherDataForCity(for city: String, completion: @escaping () -> Void) {
        WeatherAPIManager.fetchWeatherDataForCity(for: city)
            .subscribe(onNext: { [weak self] weatherData in
                self?.cityName.accept(weatherData.city.name)
                self?.temperature.accept(weatherData.list.first?.main.temp)
                self?.weatherDescription.accept(weatherData.list.first?.weather.first?.description)
                self?.firstDate.accept(self?.formatDate(weatherData.list[8].dtTxt))
                self?.firstTemperature.accept(weatherData.list[8].main.temp)
                self?.firstDescription.accept(weatherData.list[8].weather.first?.description)
                self?.secondDate.accept(self?.formatDate(weatherData.list[16].dtTxt))
                self?.secondTemperature.accept(weatherData.list[16].main.temp)
                self?.secondDescription.accept(weatherData.list[16].weather.first?.description)
                self?.thirdDate.accept(self?.formatDate(weatherData.list[24].dtTxt))
                self?.thirdTemperature.accept(weatherData.list[24].main.temp)
                self?.thirdDescription.accept(weatherData.list[24].weather.first?.description)
                completion()
            }, onError: { [weak self] error in
                self?.error.accept("Failed to fetch weather data: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    func fetchWeatherDataForCurrentLocation(completion: @escaping () -> Void) {
        LocationManager.shared.getCurrentLocation()
            .flatMap { location in
                return WeatherAPIManager.fetchWeatherDataForLocation(for: location)
            }
            .subscribe(onNext: { [weak self] weatherData in
                self?.cityName.accept(weatherData.city.name)
                self?.temperature.accept(weatherData.list.first?.main.temp)
                self?.weatherDescription.accept(weatherData.list.first?.weather.first?.description)
                self?.firstDate.accept(self?.formatDate(weatherData.list[8].dtTxt))
                self?.firstTemperature.accept(weatherData.list[8].main.temp)
                self?.firstDescription.accept(weatherData.list[8].weather.first?.description)
                self?.secondDate.accept(self?.formatDate(weatherData.list[16].dtTxt))
                self?.secondTemperature.accept(weatherData.list[16].main.temp)
                self?.secondDescription.accept(weatherData.list[16].weather.first?.description)
                self?.thirdDate.accept(self?.formatDate(weatherData.list[24].dtTxt))
                self?.thirdTemperature.accept(weatherData.list[24].main.temp)
                self?.thirdDescription.accept(weatherData.list[24].weather.first?.description)
                completion()
            }, onError: { [weak self] error in
                self?.error.accept("Failed to fetch weather data: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
