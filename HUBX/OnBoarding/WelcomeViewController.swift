//
//  WelcomeScreen.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 15.07.2023.
//

import Foundation
import UIKit
import SnapKit

class WelcomeViewController : UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    var application: UIApplication {
        return UIApplication.shared
    }
    
    // MARK: - UI Components
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    private let appNamelabel: UILabel = {
        let label = UILabel()
        label.text = "PlantApp"
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        return label
    }()
    
    private let headerStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .horizontal
        stackV.backgroundColor = .clear
        stackV.distribution = .fillProportionally
        stackV.spacing = 0
        stackV.alignment = .center
        return stackV
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Identify more than 3000+ plants and 88% accuracy."
        label.numberOfLines = 3
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.welcomeImage
        return imageView
    }()
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Get Started", for: .normal)
        btn.backgroundColor = UIColor(named: "app_green")
        btn.titleLabel?.textAlignment = .right
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.layer.masksToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(nextPageButtonTapped), for: .touchUpInside)
       
        return btn
    }()
    
    private let bottomInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "By tapping next, you are agreeing to PlantID"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Constants.text_opac_green.withAlphaComponent(0.7)
        return label
    }()
    
    private let termsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Terms of Use", for: .normal)
        btn.titleLabel?.textAlignment = .center
        return btn
    }()

    private let privacyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Privacy Policy ", for: .normal)
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private let operand : UILabel = {
        let label = UILabel()
        label.text = "&"
        label.textColor = Constants.text_opac_green.withAlphaComponent(0.7)
        label.textAlignment = .center
        return label
    }()
    
    private let bottomStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .horizontal
        stackV.backgroundColor = .clear
        stackV.distribution = .fillProportionally
        stackV.spacing = 0
        stackV.alignment = .center
        return stackV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let gradientLayer = createGradientLayer()
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        setUI()
        setUnderlines()
        //checkIsFirstLaunch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIsFirstLaunch()
    }
    
    
    func checkIsFirstLaunch(){
        if UserDefaults.standard.isFirstLaunch() {
            if Constants.isFirstPresentedTime {
                UserDefaults.standard.setIsFirstLaunch(value: false)
                Constants.isFirstPresentedTime = false
            }
            else {
                //UserDefaults.standard.setIsFirstLaunch(value: false)
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
            UserDefaults.standard.setIsFirstLaunch(value: false)
            Constants.isFirstPresentedTime = false
            self.dismiss(animated: true, completion: nil)
        }
        //self.dismiss(animated: true, completion: nil)
        
    }
    
    func setUI() {
        setHorizontalStack()
        view.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.55)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(30)
        }
        
        view.addSubview(bottomInfoLabel)
        bottomInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bottomStackView.snp.top)
            make.height.equalTo(bottomStackView.snp.height).multipliedBy(0.5)
        }
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(55)
            make.bottom.equalTo(bottomInfoLabel.snp.top).offset(-35)
            make.centerX.equalToSuperview()
        }
        
        setHeaderStackView()
        view.addSubview(headerStackView)
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(290)
            make.height.equalTo(40)
        }
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom)
            make.leading.equalTo(headerStackView.snp.leading)
            make.height.equalTo(50)
            make.trailing.equalTo(headerStackView.snp.trailing)
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(infoLabel.snp.bottom)
            make.bottom.equalTo(button.snp.top)
        }
    }
    
    func setHorizontalStack() {
        bottomStackView.addArrangedSubview(termsButton)
        bottomStackView.addArrangedSubview(operand)
        bottomStackView.addArrangedSubview(privacyButton)
    }
    
    func setHeaderStackView() {
        headerStackView.addArrangedSubview(welcomeLabel)
        headerStackView.addArrangedSubview(appNamelabel)
    }
    
    func setUnderlines(){
        UtilityHelper.setButtonUnderlineTitle(button: privacyButton, title: "Privacy Policy", font: UIFont.systemFont(ofSize: 16, weight: .regular), color:Constants.text_opac_green.withAlphaComponent(0.7))
        
        UtilityHelper.setButtonUnderlineTitle(button: termsButton, title: "Terms of Use", font: UIFont.systemFont(ofSize: 16, weight: .regular), color: Constants.text_opac_green.withAlphaComponent(0.7))
    }
    
    func createGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "gradient_1")!.withAlphaComponent(1).cgColor, UIColor(named: "gradient_2")!.withAlphaComponent(0.53).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: view.frame.minX, y: view.frame.minY)
        gradientLayer.endPoint = CGPoint(x: view.frame.maxX, y: view.frame.maxY)
        return gradientLayer
    }
    
    @objc func nextPageButtonTapped() {
        print("asdasd")
        let vc = DemoViewController()
        vc.modalPresentationStyle = .fullScreen 
        self.present(vc, animated: true, completion: nil)
    }
}


