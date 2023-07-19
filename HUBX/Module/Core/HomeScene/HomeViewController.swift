//
//  ViewController.swift
//  ESTabBarDemo
//
//  Created by Saifan Nadaf on 06/08/19.
//  Copyright © 2019 Saifan Nadaf. All rights reserved.
//

import UIKit
import SnapKit



class HomeViewController: UIViewController {
    private var searchTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Search for Plants",
            attributes: [NSAttributedString.Key.foregroundColor: Constants.app_gray]
        )
        field.returnKeyType = .continue
        field.leftViewMode = .always
        
        // Create a left view with padding for the icon
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24)) // Adjust the width as needed for your desired padding
        let iconImageView = UIImageView(image: Constants.search_icon) // Replace "your-icon-image-name" with the actual image name
        iconImageView.frame = CGRect(x: 10, y: 0, width: 24, height: 24) // Adjust the padding as needed
        leftViewContainer.addSubview(iconImageView)
        field.leftView = leftViewContainer

        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 12
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = UIColor.white
        //field.addTarget(self, action: #selector(deActiveSearch(_:)), for: .touchUpOutside)
        return field
    }()
    
    let helloMessageLabel = UILabel()
    let dailyMessageLabel = UILabel()
    
    
    let infoStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.backgroundColor = .clear
        stackV.distribution = .fillProportionally
        stackV.spacing = 0
        stackV.alignment = .leading
        return stackV
    }()
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.header_background_color
        return view
    }()
    
    let tableView = UITableView()
    let interactor = HomeInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.delegate = self
        interactor.getQuestions()
        view.backgroundColor = Constants.home_background_color
        setTableView()
        
        setUI()
    }
    
    func setTableView(){
        interactor.registerCell(tableView: tableView)
        interactor.createSectionList()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
    }
    
    func setUI() {
        setHeaderView()
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(0.4)
            make.top.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview()
        }
    }
    
    func setHeaderView(){
        let leftImageView = UIImageView()
        leftImageView.image = Constants.left_header_image
        let rightImageView = UIImageView()
        rightImageView.image = Constants.right_header_image
        
        headerView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(headerView.snp.bottom).offset(-40)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }
        
        headerView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(headerView.snp.bottom).offset(-40)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }
        
        headerView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
        }
        setHeaderMessagesStack()
        headerView.addSubview(infoStackView)
        infoStackView.snp.makeConstraints { make in
            make.bottom.equalTo(searchTextField.snp.top).offset(-5)
            make.leading.equalTo(searchTextField.snp.leading)
            make.width.equalTo(255)
            make.height.equalTo(55)
            
        }
    }
    
    func setHeaderMessagesStack() {
        setLabels()
        infoStackView.addArrangedSubview(helloMessageLabel)
        infoStackView.addArrangedSubview(dailyMessageLabel)
    }
    
    func setLabels() {
        helloMessageLabel.text = "Hi, plant lover!"
        dailyMessageLabel.text = "Good Afternoon,! ⛅️"
        helloMessageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        dailyMessageLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
//        if Constants.isFirstPresentedTime {
//            let vc = WelcomeViewController()
//            vc.modalPresentationStyle = .fullScreen
//            vc.modalTransitionStyle = .crossDissolve
//            self.present(vc, animated: true, completion: nil)
//        }
//        else {
//            self.dismiss(animated: true, completion: nil)
//        }
    }
}
extension HomeViewController: UITableViewDataSource {

    
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

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return interactor.getCellHeight(tableView, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        interactor.createHeaderView(tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 24
    }
}
extension HomeViewController: HomeInteractorDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }    
}


