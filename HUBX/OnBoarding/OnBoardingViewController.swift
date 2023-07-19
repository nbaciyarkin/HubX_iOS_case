//
//  OnBoardingViewController.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 16.07.2023.
//

import Foundation
//
//  OnboardingViewController.swift
//  SimpleOnboardingDemo
//
//  Created by jrasmusson on 2021-01-08.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let headerImageView = UIImageView()
    let centerImageView = UIImageView()
    let cornerImageView = UIImageView()
   
    
    init(headerImage: UIImage, centerImage: UIImage, cornerImage: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        headerImageView.image = headerImage
        centerImageView.image = centerImage
        if let cornerImage = cornerImage {
            cornerImageView.image = cornerImage
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
    }
}

extension OnboardingViewController {
    func setUI() {
        headerImageView.removeConstraints(headerImageView.constraints)
        view.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.height.equalTo(65)
        }
        
        centerImageView.removeConstraints(centerImageView.constraints)
        view.addSubview(centerImageView)
        centerImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(headerImageView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func setGuidesSceneConstraints() {
        headerImageView.removeConstraints(headerImageView.constraints)
        view.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.height.equalTo(55)
        }
        
        centerImageView.removeConstraints(centerImageView.constraints)
        view.addSubview(centerImageView)
        centerImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.top.equalTo(headerImageView.snp.bottom).offset(80)
            make.height.equalToSuperview().multipliedBy(0.65)
        }
        
        cornerImageView.removeConstraints(cornerImageView.constraints)
        view.addSubview(cornerImageView)
        cornerImageView.backgroundColor = .clear
        cornerImageView.snp.makeConstraints { make in
            make.leading.equalTo(centerImageView.snp.leading).offset(42)
            make.trailing.equalTo(centerImageView.snp.trailing).offset(42)
            make.height.equalTo(300)
            make.centerY.equalTo(centerImageView.snp.top).offset(75)
        }
    }
}
