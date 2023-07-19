//
//  PaymentTableViewCell.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 16.07.2023.
//

import Foundation
import UIKit
import SnapKit

class PaymentTableViewCell: UITableViewCell {
    
    static let identifier = "PaymentTableViewCell"
    
    var isYearly:Bool = false
    
    override var isSelected: Bool {
      didSet {
          if isYearly {
             saveBadge.isHidden = false
          }
          contentView.layer.borderColor = isSelected ? Constants.app_green.cgColor : CGColor(red: 0, green: 0, blue: 0, alpha: 1)
      }
    }
    
    let headerLabel = UILabel()
    let infoLabel = UILabel()
    let selectedIcon = UIImageView()
    
    let saveBadge = UIImageView()
    
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
        selectedIcon.image = Constants.emptyIcon
        saveBadge.image = UIImage(named: "year_badge")
        contentView.addSubview(selectedIcon)
        contentView.addSubview(infoStackView)
        contentView.addSubview(saveBadge)
        
        contentView.backgroundColor = Constants.text_opac_green.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 14
        contentView.layer.borderWidth = 2
       
        
        setInfoStack()
        setFonts()
        setUI()
        saveBadge.isHidden = true
        selectionStyle = .none
        contentView.layer.borderColor = Constants.app_gray.cgColor
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
           backgroundColor = .clear
           contentView.layer.borderColor = isSelected ? Constants.app_green.cgColor : CGColor(red: 0, green: 0, blue: 0, alpha: 1)
            selectedIcon.image = isSelected ? Constants.filledIcon : Constants.emptyIcon
            
       }
  
    
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
       }
    
    func setUI() {
        selectedIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(selectedIcon.snp.trailing).offset(5)
            make.trailing.equalTo(contentView.snp.trailing)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        saveBadge.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.25)
            make.bottom.equalTo(contentView.snp.centerY)
        }
        
    }
    
    func setInfoStack() {
        infoStackView.addArrangedSubview(headerLabel)
        infoStackView.addArrangedSubview(infoLabel)
    }
    
    func setText(headerText: String, infoText: String) {
        headerLabel.text = headerText
        infoLabel.text = infoText
    }
    
    func setFonts() {
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        headerLabel.textColor = .white
        infoLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        infoLabel.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
