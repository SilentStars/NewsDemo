//
//  NewsJSONModel.swift
//  NewsDemo
//
//  Created by 侯钦瀚 on 2017/11/12.
//  Copyright © 2017年 HouQinhan. All rights reserved.
//

import UIKit

class NewsJSONModel {
    var NewsTitle: String?
    var NewsSubject: String?
    var NewsImagePath: String?
    var NewsIndex: String?
    
    init (title: String, summary: String, index: String, imagePath: String) {
        self.NewsSubject = summary
        self.NewsTitle = title
        self.NewsIndex = index
        self.NewsImagePath = imagePath
    }
}
