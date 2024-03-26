//
//  WeatherViewModel.swift
//  TheWeather
//
//  Created by Damir Nuriev on 18.03.2024.
//

import RxSwift
import RxCocoa

private extension String {
    static let inputDateFormat = "yyyy-MM-dd HH:mm:ss"
    static let outputDateFormat = "dd.MM"
}

final class WeatherViewModel {
    
    //MARK: - Properties
    static let shared = WeatherViewModel()
    
    private let disposeBag = DisposeBag()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = .inputDateFormat
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
    
    //MARK: - Update UI
    func updateUI(with weatherData: WeatherData) {
        let weatherDataModel = WeatherDataModel(weatherData: weatherData)
        
        cityName.accept(weatherDataModel.cityName)
        temperature.accept(weatherDataModel.temperature)
        weatherDescription.accept(weatherDataModel.weatherDescription)
        firstDate.accept(weatherDataModel.firstDate)
        firstTemperature.accept(weatherDataModel.firstTemperature)
        firstDescription.accept(weatherDataModel.firstDescription)
        secondDate.accept(weatherDataModel.secondDate)
        secondTemperature.accept(weatherDataModel.secondTemperature)
        secondDescription.accept(weatherDataModel.secondDescription)
        thirdDate.accept(weatherDataModel.thirdDate)
        thirdTemperature.accept(weatherDataModel.thirdTemperature)
        thirdDescription.accept(weatherDataModel.thirdDescription)
    }
    
    //MARK: - Methods
    private func formatDate(_ dateString: String) -> String {
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = .outputDateFormat
        return outputFormatter.string(from: date)
    }
    
    func fetchWeatherDataForCity(for city: String, completion: @escaping () -> Void) {
        WeatherAPIManager.fetchWeatherDataForCity(for: city)
            .subscribe(onNext: { [weak self] weatherData in
                let weatherDataModel = WeatherDataModel(weatherData: weatherData)
                
                self?.cityName.accept(weatherDataModel.cityName)
                self?.temperature.accept(weatherDataModel.temperature)
                self?.weatherDescription.accept(weatherDataModel.weatherDescription)
                self?.firstDate.accept(weatherDataModel.firstDate.flatMap { self?.formatDate($0) } ?? "")
                self?.firstTemperature.accept(weatherDataModel.firstTemperature)
                self?.firstDescription.accept(weatherDataModel.firstDescription)
                self?.secondDate.accept(weatherDataModel.secondDate.flatMap { self?.formatDate($0) } ?? "")
                self?.secondTemperature.accept(weatherDataModel.secondTemperature)
                self?.secondDescription.accept(weatherDataModel.secondDescription)
                self?.thirdDate.accept(weatherDataModel.thirdDate.flatMap { self?.formatDate($0) } ?? "")
                self?.thirdTemperature.accept(weatherDataModel.thirdTemperature)
                self?.thirdDescription.accept(weatherDataModel.thirdDescription)
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
                let weatherDataModel = WeatherDataModel(weatherData: weatherData)
                
                self?.cityName.accept(weatherDataModel.cityName)
                self?.temperature.accept(weatherDataModel.temperature)
                self?.weatherDescription.accept(weatherDataModel.weatherDescription)
                self?.firstDate.accept(weatherDataModel.firstDate.flatMap { self?.formatDate($0) } ?? "")
                self?.firstTemperature.accept(weatherDataModel.firstTemperature)
                self?.firstDescription.accept(weatherDataModel.firstDescription)
                self?.secondDate.accept(weatherDataModel.secondDate.flatMap { self?.formatDate($0) } ?? "")
                self?.secondTemperature.accept(weatherDataModel.secondTemperature)
                self?.secondDescription.accept(weatherDataModel.secondDescription)
                self?.thirdDate.accept(weatherDataModel.thirdDate.flatMap { self?.formatDate($0) } ?? "")
                self?.thirdTemperature.accept(weatherDataModel.thirdTemperature)
                self?.thirdDescription.accept(weatherDataModel.thirdDescription)
                completion()
            }, onError: { [weak self] error in
                self?.error.accept("Failed to fetch weather data: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
