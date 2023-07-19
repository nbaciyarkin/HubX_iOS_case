//
//  PaywallInteractor.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 16.07.2023.
//

import Foundation
import UIKit


enum PaymentWallSectionCellType {
    case Monthly, Yearly, Feature
}

enum PaymentWallSectionItemType {
    case InfoCard, PaymentSelection
}

class PaymentCellItem {
    var cellIdentifier: String?
    var cellType: PaymentWallSectionCellType?
}

class PaymentSectionItem {
    var cellList = [PaymentCellItem]()
    var sectionType: PaymentWallSectionItemType?
}

class PaywallInteractor {
    
    enum CellType: String {
        case Features = "Features"
        case PaymentSelection = "PaymentSelection"
        case PaymentButton = "PaymentButton"
    }
    
    var sectionList = [PaymentSectionItem]()
    
    func setDissmisButton(btn: UIButton){
        //
    }
    
    func registerCell(tableView: UITableView){
        tableView.register(PaymentTableViewCell.self, forCellReuseIdentifier: PaymentTableViewCell.identifier)
        tableView.register(FeaturesCollectionTableCell.self, forCellReuseIdentifier: FeaturesCollectionTableCell.identifier)
    }
    
    func createPaywallCell(tableView: UITableView, indexPath: IndexPath) -> PaymentTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTableViewCell.identifier, for: indexPath) as! PaymentTableViewCell
        
        let sectionItem = sectionList[indexPath.section]
        if sectionItem.sectionType == .PaymentSelection {
            if sectionItem.cellList[indexPath.row].cellType == .Monthly {
                cell.setText(headerText: "1 Month", infoText: "$2.99/month, auto renewable")
                cell.isYearly = false
            }
            else if sectionItem.cellList[indexPath.row].cellType == .Yearly  {
                cell.setText(headerText: "1 Year", infoText: "First 3 days free, then $529,99/year")
                cell.isYearly = true
            }
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func createFeatureCell(tableView: UITableView, indexPath: IndexPath) -> FeaturesCollectionTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeaturesCollectionTableCell.identifier, for: indexPath) as! FeaturesCollectionTableCell
        cell.backgroundColor = .clear
        return cell
    }
    
    func createSectionList() {
        self.sectionList.removeAll()
        
        let featuresSection = PaymentSectionItem()
        featuresSection.sectionType = .InfoCard
        featuresSection.cellList = createFeaturesSectionCellList()
        sectionList.append(featuresSection)
        
        let topSection = PaymentSectionItem()
        topSection.sectionType = .PaymentSelection
        topSection.cellList = createTopSectionCellList()
        sectionList.append(topSection)
    }
    
    func createTopSectionCellList() -> [PaymentCellItem]{
        var list = [PaymentCellItem]()
        let monthlyPayInfo = PaymentCellItem()
        monthlyPayInfo.cellType = .Monthly
        monthlyPayInfo.cellIdentifier = PaymentTableViewCell.identifier
        list.append(monthlyPayInfo)
        
        let yearlyPayInfo = PaymentCellItem()
        yearlyPayInfo.cellType = .Yearly
        yearlyPayInfo.cellIdentifier = PaymentTableViewCell.identifier
        list.append(yearlyPayInfo)
        return list
    }
    
    func createFeaturesSectionCellList() -> [PaymentCellItem]{
        var list = [PaymentCellItem]()
        let featureCards = PaymentCellItem()
        featureCards.cellType = .Feature
        featureCards.cellIdentifier = FeaturesCollectionTableCell.identifier
        list.append(featureCards)
        return list
    }
}

//MARK: - Table View
extension PaywallInteractor {
    func createTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let sectionItem = sectionList[indexPath.section]
        if sectionItem.sectionType == .PaymentSelection {
            return createPaywallCell(tableView: tableView, indexPath: indexPath)
        }
        else if sectionItem.sectionType == .InfoCard {
            return createFeatureCell(tableView: tableView, indexPath: indexPath)
        }
        return UITableViewCell()
    }
    
    
    
    func getCellHeight(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        
        let sectionItem = sectionList[indexPath.section]
        if sectionItem.sectionType == .InfoCard {
            if sectionItem.cellList[indexPath.row].cellType == .Feature {
                return 180
            }
        }
        else if sectionItem.sectionType == .PaymentSelection {
            if sectionItem.cellList[indexPath.row].cellType == .Monthly {
                return 85
            }
            else if sectionItem.cellList[indexPath.row].cellType == .Yearly  {
               return 85
            }
        }
        return 100
    }
}
