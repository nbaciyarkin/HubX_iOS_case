//
//  PlantTypesCollectionCell.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//

import Foundation
import SnapKit
import UIKit

class PlantTypeCollectionCell: UICollectionViewCell {
    static let identifier = "PlantTypeCollectionCell"
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.image = Constants.plant_photo
        img.layer.cornerRadius = 14
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Edible Plants"
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = Constants.app_gray.cgColor
        setUI()

    }
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(imageView)
       
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
            make.trailing.equalToSuperview()
        }

        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.top.equalTo(contentView.snp.top).offset(16)
            make.width.equalTo(48)
            make.height.equalTo(42)
        }
    }
}
