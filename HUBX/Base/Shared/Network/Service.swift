//
//  Service.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 18.07.2023.
//

import Foundation
import Alamofire

class Service{
    static func getQuestions(onSucces: @escaping (Questions) -> (), onError: @escaping (AFError) -> ()) {
        ServiceManager.shared.fetch(path: ApiCaller.ServiceEndPoint.getQuestionsEndpPoint()) { (response: Questions) in
            onSucces(response)
        } onError: { error in
            onError(error)
        }
    }
    
    static func getPlants(onSucces: @escaping (Plants) -> (), onError: @escaping (AFError) -> ()) {
        ServiceManager.shared.fetch(path: ApiCaller.ServiceEndPoint.getCategoriesEndpPoint()) { (response: Plants) in
            onSucces(response)
        } onError: { error in
            onError(error)
        }
    }
}
