//
//  FeaturesCollectionTableCell.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 17.07.2023.
//

import Foundation

import Foundation
import UIKit
import SnapKit

class FeaturesCollectionTableCell: UITableViewCell {
    
    static let identifier = "FeaturesCollectionTableCell"
    
    private let featuresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 156  , height: 150)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FeaturesCollectionViewCell.self, forCellWithReuseIdentifier: FeaturesCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        featuresCollectionView.delegate = self
        featuresCollectionView.dataSource = self
       
        setUI()
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 1))
       }

    func setUI() {
        contentView.addSubview(featuresCollectionView)
        featuresCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeaturesCollectionTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturesCollectionViewCell.identifier, for: indexPath) as? FeaturesCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 1 {
            cell.imageView.image = Constants.faster_mini_icon!
            cell.subLable.text = "Faster"
            cell.infoLabel.text = "Process"
        }
       return cell
    }
}

