//
//  UserDefaultsUtils.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 15.07.2023.
//


import Foundation
extension UserDefaults {
    
    enum UserDefaultKeys: String {
        case isFirstLaunch
        case currentUserId
        case currentUser
        case userNickname
    }
    
    func setIsFirstLaunch(value: Bool){
        set(value,forKey: UserDefaultKeys.isFirstLaunch.rawValue)
        synchronize()
    }
    
    func isFirstLaunched() -> Bool {
        return bool(forKey: UserDefaultKeys.isFirstLaunch.rawValue)
    }
}
