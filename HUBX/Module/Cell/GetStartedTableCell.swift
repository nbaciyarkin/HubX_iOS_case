//
//  GetStartedTableCell.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

protocol GetStartedTableCellDelegate: AnyObject {
    func didTappedGetStartedCell(_ cell: GetStartedTableCell ,indexPath:IndexPath)
}

class GetStartedTableCell: UITableViewCell {
    
    static let identifier = "GetStartedTableCell"
    
    weak var delegate: GetStartedTableCellDelegate?
    
    var questionList = [Question]() {
        didSet{
            DispatchQueue.main.async {
                self.getStartedCollectionView.reloadData()
            }
        }
    }
    
    private let getStartedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 240 , height: 160)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GetStartedCollectionCell.self, forCellWithReuseIdentifier: GetStartedCollectionCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(getStartedCollectionView)
        getStartedCollectionView.delegate = self
        getStartedCollectionView.dataSource = self
        selectionStyle = .none
        setUI()
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
       }

    func setUI() {
        getStartedCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalToSuperview()
        }
    }
    
    func sentData(list:[Question]){
        self.questionList = list
        DispatchQueue.main.async {
            self.getStartedCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GetStartedTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GetStartedCollectionCell.identifier, for: indexPath) as? GetStartedCollectionCell else {
            return UICollectionViewCell()
           
        }
        let question = questionList[indexPath.row]
        if let url = URL(string: question.image_uri ??  "https://firebasestorage.googleapis.com/v0/b/flora---plant-identifier.appspot.com/o/public%2Fcard2.png?alt=media"){
            let title = question.title
            cell.setData(title: title ?? "How to plant identify?", questionImageURL: url)
            print(question)
           return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTappedGetStartedCell(self, indexPath: indexPath)
    }
    

}

