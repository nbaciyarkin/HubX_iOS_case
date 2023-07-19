//
//  WebViewInteracotr.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 19.07.2023.
//

import Foundation
import UIKit

class WebViewInteractor {
    var nav: UINavigationController?
    
    init(nav: UINavigationController?){
        self.nav = nav
    }
    
    func showDetail(URL: String) {
        let controller = WebViewController()
        controller.configure(with: URL)
        nav?.present(controller, animated: true, completion: nil)
    }
}
