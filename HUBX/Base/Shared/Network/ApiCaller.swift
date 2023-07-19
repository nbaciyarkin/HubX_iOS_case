//
//  ApiCaller.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//

import Foundation

class ApiCaller {
    
}

//https://dummy-api-jtg6bessta-ey.a.run.app/getCategories

//https://dummy-api-jtg6bessta-ey.a.run.app/getQuestions

extension ApiCaller {
    enum ServiceEndPoint: String {
        case Base_URL = "https://dummy-api-jtg6bessta-ey.a.run.app"
        case getCategories = "/getCategories"
        case getQuestions = "/getQuestions"
        
        static func getCategoriesEndpPoint() -> String {
            return  "\(Base_URL.rawValue)\(getCategories.rawValue)"
        }
        
        static func getQuestionsEndpPoint() -> String {
            return  "\(Base_URL.rawValue)\(getQuestions.rawValue)"
        }
    }
}

