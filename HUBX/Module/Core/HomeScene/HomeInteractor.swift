//
//  HomeInteractor.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//
import Foundation
import UIKit

enum HomeSectionCellType {
    case UpgradeAccount, GetStarted, Plants
}

enum HomneSectionItemType {
    case UpgradeAccount, GetStarted, Plants
}

class HomeCellItem {
    var cellIdentifier: String?
    var cellType: HomeSectionCellType?
}

class HomeSectionItem {
    var cellList = [HomeCellItem]()
    var sectionType: HomneSectionItemType?
}

protocol HomeInteractorDelegate: AnyObject {
    func reloadData()
}
class HomeInteractor {
    
    enum CellType: String {
        case UpgradeAccount = "UpgradeAccount"
        case GetStarted = "GetStarted"
        case Feature = "Plants"
    }
    
    var questionList = [Question]()
    
    weak var delegate: HomeInteractorDelegate?
    var sectionList = [HomeSectionItem]()
    
    
    func registerCell(tableView: UITableView){
        tableView.register(UpgradeAccountTableViewCell.self, forCellReuseIdentifier: UpgradeAccountTableViewCell.identifier)
        tableView.register(GetStartedTableCell.self, forCellReuseIdentifier: GetStartedTableCell.identifier)
        tableView.register(PlantTypeCollectionTableCell.self, forCellReuseIdentifier: PlantTypeCollectionTableCell.identifier)
    }
    
    func createUpgradeAccountCell(tableView: UITableView, indexPath: IndexPath) -> UpgradeAccountTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UpgradeAccountTableViewCell.identifier, for: indexPath) as! UpgradeAccountTableViewCell
        let sectionItem = sectionList[indexPath.section]
        if sectionItem.sectionType == .UpgradeAccount {
            cell.setTContent(headerText: "FREE Premium Available", infoText: "Tap to upgrade your account!", leftIcon: Constants.badged_mail_icon!, goIcon: Constants.right_arrow!)
        cell.backgroundColor = .clear
        }
        return cell
    }
        
    func createGetStartedCell(tableView: UITableView, indexPath: IndexPath) -> GetStartedTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GetStartedTableCell.identifier, for: indexPath) as! GetStartedTableCell
        cell.sentData(list: self.questionList)
        return cell
    }
    
    func createPlantsCell(tableView: UITableView, indexPath: IndexPath) -> PlantTypeCollectionTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlantTypeCollectionTableCell.identifier, for: indexPath) as! PlantTypeCollectionTableCell
        return cell
    }
    
    
    func createSectionList() {
        self.sectionList.removeAll()
        
        let featuresSection = HomeSectionItem()
        featuresSection.sectionType = .UpgradeAccount
        featuresSection.cellList = createUpgradeAccountSectionCellList()
        sectionList.append(featuresSection)
        
        let getstartedSection = HomeSectionItem()
        getstartedSection.sectionType = .GetStarted
        getstartedSection.cellList = createGetStartedSectionCellList()
        sectionList.append(getstartedSection)
        
        let getPlants = HomeSectionItem()
        getPlants.sectionType = .Plants
        getPlants.cellList = createPlantsSectionCellList()
        sectionList.append(getPlants)
        delegate?.reloadData()
    }
    
    func createUpgradeAccountSectionCellList() -> [HomeCellItem]{
        var list = [HomeCellItem]()
        let upgradeAccountInfo = HomeCellItem()
        upgradeAccountInfo.cellType = .UpgradeAccount
        upgradeAccountInfo.cellIdentifier = UpgradeAccountTableViewCell.identifier
        list.append(upgradeAccountInfo)
        return list
    }
    
    func createGetStartedSectionCellList() -> [HomeCellItem]{
        var list = [HomeCellItem]()
        let getStartedCards = HomeCellItem()
        getStartedCards.cellType = .GetStarted
        getStartedCards.cellIdentifier = GetStartedTableCell.identifier
        list.append(getStartedCards)
        return list
    }
    
    func createPlantsSectionCellList() -> [HomeCellItem]{
        var list = [HomeCellItem]()
        let getPlantCards = HomeCellItem()
        getPlantCards.cellType = .Plants
        getPlantCards.cellIdentifier = PlantTypeCollectionTableCell.identifier
        list.append(getPlantCards)
        return list
    }
}

//MARK: - Table View
extension HomeInteractor {
    func createTableViewCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let sectionItem = sectionList[indexPath.section]
        if sectionItem.sectionType == .UpgradeAccount {
            return createUpgradeAccountCell(tableView: tableView, indexPath: indexPath)
        }
        else if sectionItem.sectionType == .GetStarted {
            return createGetStartedCell(tableView: tableView, indexPath: indexPath)
        }
        else if sectionItem.sectionType == .Plants {
            return createPlantsCell(tableView: tableView, indexPath: indexPath)
        }
        return UITableViewCell()
    }
    
    func getCellHeight(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        let sectionItem = sectionList[indexPath.section]
        if sectionItem.sectionType == .UpgradeAccount {
           return 68
        }
        else if sectionItem.sectionType == .GetStarted {
            if sectionItem.cellList[indexPath.row].cellType == .GetStarted {
                return 180
            }
        }
        else if sectionItem.sectionType == .Plants {
            if sectionItem.cellList[indexPath.row].cellType == .Plants {
                return 720
            }
        }
        return 100
    }
    
    func createHeaderView(_ tableView: UITableView, section: Int) -> UIView? {
        let sectionItem = sectionList[section]
        if sectionItem.sectionType == .GetStarted {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            let label = UILabel()
            label.text = "Get Started"
            label.textColor = UIColor.black // Set the text color
            label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            headerView.addSubview(label)
            label.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(24)
                make.height.equalToSuperview()
            }
            return headerView
        }
        else {
            return nil
        }
    }
}

// fetch how to use it
extension HomeInteractor {
    func getQuestions() {
        Service.getQuestions { response in
            print(response)
            self.questionList.append(contentsOf: response)
            self.delegate?.reloadData()
        } onError: { error in
            print(error)
        }
    }
   
}

// fetch plants
extension HomeInteractor {
    
}
    

