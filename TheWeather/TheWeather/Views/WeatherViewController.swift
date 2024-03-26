//
//  WeatherViewController.swift
//  TheWeather
//
//  Created by Damir Nuriev on 18.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

private extension UIFont {
    static let font20: UIFont = UIFont.systemFont(ofSize: 20)
    static let font35: UIFont = UIFont.systemFont(ofSize: 35)
    static let font50: UIFont = UIFont.systemFont(ofSize: 50)
}

private extension CGFloat {
    static let offset5: CGFloat = 5.0
    static let offset10: CGFloat = 10.0
    static let offset16: CGFloat = 16.0
    static let offset30: CGFloat = 30.0
    static let offset55: CGFloat = 55.0
    static let offset200: CGFloat = 200.0
}

private extension String {
    static let celsius = "°C"
}

final class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel = WeatherViewModel()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font35
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font50
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let firstDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let firstTemperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let firstDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let secondDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let secondTemperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let thirdDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let thirdTemperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    private let thirdDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .font20
        return label
    }()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Flow
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.cityName
            .bind(to: cityNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.temperature
            .map { "\(String(Int($0 ?? 0)))\(String.celsius)" }
            .bind(to: temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.weatherDescription
            .bind(to: weatherDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.firstDate
            .bind(to: firstDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.firstTemperature
            .map { "\(String(Int($0 ?? 0)))\(String.celsius)" }
            .bind(to: firstTemperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.firstDescription
            .bind(to: firstDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.secondDate
            .bind(to: secondDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.secondTemperature
            .map { "\(String(Int($0 ?? 0)))\(String.celsius)" }
            .bind(to: secondTemperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.secondDescription
            .bind(to: secondDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.thirdDate
            .bind(to: thirdDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.thirdTemperature
            .map { "\(String(Int($0 ?? 0)))\(String.celsius)" }
            .bind(to: thirdTemperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.thirdDescription
            .bind(to: thirdDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.addSubview(cityNameLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherDescriptionLabel)
        view.addSubview(firstDateLabel)
        view.addSubview(firstTemperatureLabel)
        view.addSubview(firstDescriptionLabel)
        view.addSubview(secondDateLabel)
        view.addSubview(secondTemperatureLabel)
        view.addSubview(secondDescriptionLabel)
        view.addSubview(thirdDateLabel)
        view.addSubview(thirdTemperatureLabel)
        view.addSubview(thirdDescriptionLabel)
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset200)
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityNameLabel.snp.bottom).offset(CGFloat.offset10)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(CGFloat.offset10)
        }
        
        firstDateLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(CGFloat.offset30)
            make.left.equalToSuperview().offset(CGFloat.offset16)
            make.width.equalTo(CGFloat.offset55)
        }
        
        firstTemperatureLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstDateLabel)
            make.left.equalTo(firstDateLabel.snp.right).offset(CGFloat.offset5)
            make.width.equalTo(CGFloat.offset55)
        }
        
        firstDescriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstDateLabel)
            make.left.equalTo(firstTemperatureLabel.snp.right).offset(CGFloat.offset5)
            make.right.equalToSuperview().inset(CGFloat.offset16)
        }
        
        secondDateLabel.snp.makeConstraints { make in
            make.top.equalTo(firstDateLabel.snp.bottom).offset(CGFloat.offset10)
            make.left.equalToSuperview().offset(CGFloat.offset16)
            make.width.equalTo(CGFloat.offset55)
        }
        
        secondTemperatureLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondDateLabel)
            make.left.equalTo(secondDateLabel.snp.right).offset(CGFloat.offset5)
            make.width.equalTo(CGFloat.offset55)
        }
        
        secondDescriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondDateLabel)
            make.left.equalTo(secondTemperatureLabel.snp.right).offset(CGFloat.offset5)
            make.right.equalToSuperview().inset(CGFloat.offset16)
        }
        
        thirdDateLabel.snp.makeConstraints { make in
            make.top.equalTo(secondDateLabel.snp.bottom).offset(CGFloat.offset10)
            make.left.equalToSuperview().offset(CGFloat.offset16)
            make.width.equalTo(CGFloat.offset55)
        }
        
        thirdTemperatureLabel.snp.makeConstraints { make in
            make.centerY.equalTo(thirdDateLabel)
            make.left.equalTo(thirdDateLabel.snp.right).offset(CGFloat.offset5)
            make.width.equalTo(CGFloat.offset55)
        }
        
        thirdDescriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(thirdDateLabel)
            make.left.equalTo(thirdTemperatureLabel.snp.right).offset(CGFloat.offset5)
            make.right.equalToSuperview().inset(CGFloat.offset16)
        }
    }
}
