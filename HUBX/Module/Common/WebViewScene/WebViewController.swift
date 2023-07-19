//
//  WebViewController.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 19.07.2023.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    var webURL:String?
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(webView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func configure(with url: String?) {

        if let url = URL(string: url ?? "https://firebasestorage.googleapis.com/v0/b/flora---plant-identifier.appspot.com/o/public%2Fcard2.png?alt=media") {
            webView.load(URLRequest(url: url))
        }
    }
       
}




