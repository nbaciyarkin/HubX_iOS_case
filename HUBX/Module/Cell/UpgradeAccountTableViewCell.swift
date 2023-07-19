//
//  UpgradeAccountTableView.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//

import Foundation
import UIKit

class UpgradeAccountTableViewCell: UITableViewCell {
    static let identifier = "UpgradeAccountTableViewCell"
    
    let headerLabel = UILabel()
    let infoLabel = UILabel()
    
    let selectedIcon = UIImageView()
    let rightIcon = UIImageView()
    
    let infoStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.backgroundColor = .clear
        stackV.distribution = .fillProportionally
        stackV.spacing = 0
        stackV.alignment = .leading
        return stackV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        selectedIcon.image = Constants.emptyIcon
        rightIcon.image = UIImage(named: "year_badge")
        contentView.addSubview(selectedIcon)
        contentView.addSubview(infoStackView)
        contentView.addSubview(rightIcon)
        contentView.layer.cornerRadius = 14
        setInfoStack()
        setFonts()
        setUI()
        selectionStyle = .none
        selectedIcon.clipsToBounds = true
        selectedIcon.contentMode = .scaleAspectFill
        
    }
    
  
    
    override func layoutSubviews() {
           super.layoutSubviews()
        selectedIcon.clipsToBounds = true
        selectedIcon.contentMode = .scaleAspectFill
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
       }
    
    func setUI() {
        selectedIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(50)
            make.top.equalTo(contentView.snp.top).offset(17)
            make.width.equalTo(45)
        }
        rightIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(selectedIcon.snp.trailing).offset(5)
            make.trailing.equalTo(rightIcon.snp.trailing)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func setInfoStack() {
        infoStackView.addArrangedSubview(headerLabel)
        infoStackView.addArrangedSubview(infoLabel)
    }
    
    func setTContent(headerText: String, infoText: String, leftIcon: UIImage, goIcon: UIImage) {
        headerLabel.text = headerText
        infoLabel.text = infoText
        selectedIcon.image = leftIcon
        rightIcon.image = goIcon
        selectedIcon.contentMode = .scaleToFill
    }
    
    func setFonts() {
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        headerLabel.textColor = Constants.gold_opac
        infoLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        infoLabel.textColor = Constants.gold_mid_opac
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
