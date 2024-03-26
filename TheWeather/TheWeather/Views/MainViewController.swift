//
//  MainViewController.swift
//  TheWeather
//
//  Created by Damir Nuriev on 18.03.2024.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

private extension String {
    static let enterCity = "Enter city"
    static let search = "Search"
    static let myLocation = "My Location"
}

private extension CGFloat {
    static let offset10: CGFloat = 10.0
    static let offset20: CGFloat = 20.0
    static let offset30: CGFloat = 30.0
    static let offset70: CGFloat = 70.0
    static let offset110: CGFloat = 110.0
    static let offset200: CGFloat = 200.0
}

private extension UIColor {
    static let searchFieldColor = UIColor(red: 250/255, green: 186/250, blue: 187/250, alpha: 1)
}

final class MainViewController: UIViewController {
    
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = WeatherViewModel()
    
    private let cityTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .searchFieldColor
        textField.placeholder = .enterCity
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(.search, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.contentMode = .center
        return button
    }()
    
    private let locationButton: UIButton = {
        let button = UIButton()
        button.setTitle(.myLocation, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.contentMode = .center
        return button
    }()

    //MARK: - Flow
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        bindViewModel()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.addSubview(cityTextField)
        view.addSubview(searchButton)
        view.addSubview(locationButton)
        
        cityTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset200)
            make.left.equalToSuperview().offset(CGFloat.offset20)
            make.height.equalTo(CGFloat.offset30)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset200)
            make.left.equalTo(cityTextField.snp.right).offset(CGFloat.offset10)
            make.right.equalToSuperview().inset(CGFloat.offset20)
            make.height.equalTo(CGFloat.offset30)
            make.width.equalTo(CGFloat.offset70)
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityTextField.snp.bottom).offset(CGFloat.offset10)
            make.width.equalTo(CGFloat.offset110)
            make.height.equalTo(CGFloat.offset30)
        }
    }
    
    //MARK: - Bind
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
