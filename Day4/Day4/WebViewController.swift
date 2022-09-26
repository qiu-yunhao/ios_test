//
//  WebViewController.swift
//  Day4
//
//  Created by hello on 2022/9/26.
//

import Foundation
import UIKit
import WebKit

class WebViewCotroller : UIViewController, WKNavigationDelegate {
    private let webView = WKWebView()
    var data: String = ""
    

    
    override func viewDidLoad() {
        let url = data
        webView.load(URLRequest(url: URL(string: url)!))
        view = webView
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
}
