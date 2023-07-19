//
//  PaywallScreen.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 16.07.2023.
//

import Foundation
import UIKit
import SnapKit

class PaywallViewController: UIViewController {
    
    // MARK: - UI Components
    let headerTitleImage = UIImageView()
    let imageView = UIImageView()
    let headerContainer = UIView()

    let tableView = UITableView()
    
    let bottomInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "After the 3-day free trial period you’ll be charged ₺274.99 per year unless you cancel before the trial expires. Yearly Subscription is Auto-Renewable"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 9, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.52)
        return label
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Try Free for 3 days", for: .normal)
        btn.backgroundColor = UIColor(named: "app_green")
        btn.titleLabel?.textAlignment = .right
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.layer.masksToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        //btn.addTarget(self, action: #selector(nextPageButtonTapped), for: .touchUpInside)
       
        return btn
    }()
    
    let buttomPrivacyContent = UIImageView()
    
    let interactor = PaywallInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.paywall_background_color
        tableView.delegate = self
        tableView.dataSource = self
        interactor.registerCell(tableView: tableView)
        interactor.createSectionList()
        blurredContainerBackground()
        setUI()
        tableView.backgroundColor = .clear
    }
    
    func setHeaderContainerConstraints() {
        headerTitleImage.image = Constants.paywallHeader!
        imageView.image = Constants.paywall_image!
        
        headerContainer.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(headerContainer.snp.centerY)
            make.top.equalTo(headerContainer.snp.top).offset(20)
            make.centerX.equalTo(headerContainer.snp.centerX)
            make.height.equalTo(headerContainer.snp.height).multipliedBy(1.4)
            make.width.equalTo(headerContainer.snp.width)
            
        }
        
        headerContainer.addSubview(headerTitleImage)
        headerTitleImage.snp.makeConstraints { make in
            make.leading.equalTo(headerContainer.snp.leading).offset(24)
            make.trailing.equalTo(headerContainer.snp.trailing).offset(-27)
            make.height.equalTo(70)
            make.bottom.equalTo(headerContainer.snp.bottom).offset(2)
        }
    }
    
    func setUI(){
        setHeaderContainerConstraints()
        
        headerContainer.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.40)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerContainer.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.42)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom).offset(18)
            make.height.equalTo(52)
            make.leading.equalTo(tableView.snp.leading).offset(16)
            make.trailing.equalTo(tableView.snp.trailing).offset(-16)
        }
        
        view.addSubview(buttomPrivacyContent)
        buttomPrivacyContent.image = Constants.paywall_terms_privacy!
        buttomPrivacyContent.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(13)
        }
        view.addSubview(bottomInfoLabel)
        bottomInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(10)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(button.snp.width)
        }
    }
    
    func blurredContainerBackground() {
        // Create a blur effect
        view.addSubview(headerContainer)
        let imgV = UIImageView()
        imgV.image = Constants.paywall_container_image!
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imgV.bounds
        imgV.addSubview(blurView)
        headerContainer.addSubview(imgV)
        headerContainer.sendSubviewToBack(imgV)
        imgV.snp.makeConstraints { make in
            make.width.equalTo(headerContainer.snp.width)
            make.centerY.equalTo(headerContainer.snp.centerY)
            make.centerX.equalTo(headerContainer.snp.centerX)
            make.height.equalTo(headerContainer.snp.height)
        }
    }
    
}

//MARK: - UITableViewDatasource
extension PaywallViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.sectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.sectionList[section].cellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return interactor.createTableViewCell(tableView, indexPath)
    }
}

//MARK: - UITableViewDelegate
extension PaywallViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return interactor.getCellHeight(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
