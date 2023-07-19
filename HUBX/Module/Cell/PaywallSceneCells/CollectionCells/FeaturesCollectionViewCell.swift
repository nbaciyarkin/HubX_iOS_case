//
//  FeaturesCollectionViewCell.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 17.07.2023.
//

import Foundation
import UIKit
import SnapKit

class FeaturesCollectionViewCell: UICollectionViewCell {

    static let identifier = "FeaturesCollectionViewCell"
    
    var containerView =  UIView()
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.image = Constants.scanner_mini_icon
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Unlimited"
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()

    var subLable: UILabel = {
        let lbl = UILabel()
        lbl.text = "Plant Identify"
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .light)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()
    
    let infoStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.backgroundColor = .clear
        stackV.distribution = .fillProportionally
        stackV.spacing = 2
        stackV.alignment = .leading
        return stackV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 14
        self.layer.masksToBounds = true
        setUI()
        contentView.backgroundColor = Constants.text_opac_green.withAlphaComponent(0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func setUI() {
        containerView.backgroundColor = Constants.paywall_background_color.withAlphaComponent(0.9)
        containerView.addSubview(imageView)
        containerView.layer.cornerRadius = 8
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.top.equalTo(contentView.snp.top).offset(16)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.centerX.equalTo(containerView.snp.centerX)
            make.height.equalTo(18)
            make.width.equalTo(18)
        }
        contentView.addSubview(containerView)
        
        infoStackView.addArrangedSubview(infoLabel)
        infoStackView.addArrangedSubview(subLable)
        
        contentView.addSubview(infoStackView)
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading)
            make.width.equalTo(100)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //containerView.frame = contentView.bounds
    }
    
}

