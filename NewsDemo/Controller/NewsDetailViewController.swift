//
//  NewsDetailViewController.swift
//  NewsDemo
//
//  Created by 侯钦瀚 on 2017/11/13.
//  Copyright © 2017年 HouQinhan. All rights reserved.
//

import UIKit
import Alamofire


class NewsDetailViewController: UIViewController {
    
    var webView: UIWebView!
    var indexToTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        Alamofire.request("http://open.twtstudio.com/api/v1/news/\(self.indexToTitle)").responseJSON { response in
            switch response.result {
            case .success(let json):
                //self.webView.load(response.result.value!, mimeType: "text/html", textEncodingName: "utf-8", baseURL: NSURL() as URL)
                let dic = json as! Dictionary<String, Any>
                let dicData = dic["data"] as! Dictionary<String, Any>
                let contentStr: String = dicData["content"] as! String
                self.webView.loadHTMLString(contentStr, baseURL: nil)
            case .failure(let error):
                print("\(error)")
            }
        }
        
    }
}
