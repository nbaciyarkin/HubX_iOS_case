//
//  PlantTypeCollectionTableCell.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//

import Foundation
import UIKit
import SnapKit


class PlantTypeCollectionTableCell: UITableViewCell {
    
    static let identifier = "PlantTypeCollectionTableCell"
    
    private let plantTypesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 178 , height: 172)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PlantTypeCollectionCell.self, forCellWithReuseIdentifier: PlantTypeCollectionCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(plantTypesCollectionView)
        plantTypesCollectionView.delegate = self
        plantTypesCollectionView.dataSource = self
        setUI()
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
       }

    func setUI() {
        plantTypesCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(800)
        }
    }
    
    func setData() {
        //
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlantTypeCollectionTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // api bağlayınca düzenlenecek
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantTypeCollectionCell.identifier, for: indexPath) as? PlantTypeCollectionCell else {
            // api bağlayınca düzenlenecek
            return UICollectionViewCell()
        }
       return cell
    }
}
