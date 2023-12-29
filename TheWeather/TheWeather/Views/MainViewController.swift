//
//  MainViewController.swift
//  TheWeather
//
//  Created by Damir Nuriev on 26.12.2023.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = WeatherViewModel()
    
    private let cityTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(red: 250/255, green: 186/250, blue: 187/250, alpha: 1)
        textField.placeholder = "Enter city"
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.contentMode = .center
        return button
    }()
    
    private let locationButton: UIButton = {
        let button = UIButton()
        button.setTitle("My Location", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.contentMode = .center
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.addSubview(cityTextField)
        view.addSubview(searchButton)
        view.addSubview(locationButton)
        
        cityTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalTo(cityTextField.snp.right).offset(10)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityTextField.snp.bottom).offset(10)
            make.width.equalTo(110)
            make.height.equalTo(30)
        }
    }
    
    private func bindViewModel() {
        viewModel.cityName
            .bind(to: cityTextField.rx.text)
            .disposed(by: disposeBag)
        
        searchButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let city = self?.cityTextField.text else { return }
                self?.viewModel.fetchWeatherDataForCity(for: city, completion: {
                    DispatchQueue.main.async {
                        self?.showWeatherScreen()
                    }
                })
            })
            .disposed(by: disposeBag)
        
        locationButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.fetchWeatherDataForCurrentLocation(completion: {
                    DispatchQueue.main.async {
                        self?.showWeatherScreen()
                    }
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func showWeatherScreen() {
        let weatherViewController = WeatherViewController(viewModel: viewModel)
        navigationController?.pushViewController(weatherViewController, animated: true)
    }
}
