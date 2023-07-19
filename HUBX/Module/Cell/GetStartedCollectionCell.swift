//
//  HomeGetStartedCollectionCell.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//

import Foundation
import UIKit
import SnapKit

class GetStartedCollectionCell: UICollectionViewCell {
    static let identifier = "GetStartedCollectionCell"
    

    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.image = Constants.identify_plants_image
        img.layer.cornerRadius = 14
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "How to identify plants with PlantApp?"
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true
        containerView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = contentView.bounds
        containerView.addSubview(blurView)
        setUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    func setData() {
        //
    }
    
    func setUI() {
        contentView.addSubview(imageView)
        self.contentView.sendSubviewToBack(imageView)
       
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.height)
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalToSuperview()
        }
        
        containerView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(14)
            make.centerY.equalTo(containerView.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).offset(-24)
        }
    }
}
