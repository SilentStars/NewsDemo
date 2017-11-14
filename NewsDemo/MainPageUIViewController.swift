//
//  MainPageUIViewController.swift
//  NewsDemo
//
//  Created by 侯钦瀚 on 2017/11/12.
//  Copyright © 2017年 HouQinhan. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class MainPageUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newsTableView: UITableView?
    var newsData: [NewsJSONModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.newsTableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        self.newsTableView?.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        self.newsTableView?.dataSource = self
        self.newsTableView?.delegate = self
        self.newsTableView?.separatorStyle = .singleLine
        self.view.addSubview(self.newsTableView!)
        
        
        //发起网络请求，将内容存入数组[NewsJSONModel]
        Alamofire.request("https://open.twtstudio.com/api/v1/news/1/page/1").responseJSON { response in
            switch response.result {
            case .success(let json):
                let dic = json as! Dictionary<String, Any>
                let dicData = dic["data"] as! [Dictionary<String, Any>]
                for i in 0..<dicData.count {
                    var model = NewsJSONModel(title: dicData[i]["subject"] as! String, summary: dicData[i]["summary"] as! String, index: dicData[i]["index"] as! String, imagePath: (dicData[i]["pic"] as? String)!)
                    self.newsData?.append(model)
                }
                self.newsTableView?.reloadData()
            case .failure(let error):
                print("\(error)")
            }
        }
        
        print("\(self.newsData?.count)")
//        self.newsTableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
//        self.newsTableView?.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
//        self.newsTableView?.dataSource = self
//        self.newsTableView?.delegate = self
//        self.newsTableView?.separatorStyle = .singleLine
//        self.view.addSubview(self.newsTableView!)
    }
    //首页 Cell 数目
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData!.count
    }
    //自定义 Cell 函数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.titleLabel.text = self.newsData![indexPath.row].NewsTitle
        cell.subjectLabel.text = self.newsData![indexPath.row].NewsSubject
        //print(self.newsData[indexPath.row].NewsImagePath)
        //print(self.newsData![indexPath.row].NewsImagePath)
        //cell.imgView.sd_setImage(with: URL(string: self.newsData[indexPath.row].NewsImagePath))
        //cell.imgView.sd_setImage(with: URL(string: self.newsData[indexPath.row].NewsImagePath), completed: nil)
        //cell.imgView.sd_setImage(with: URL(string: "https://open.twtstudio.com/imgcache/452c3cc4d123f1028858715143f713ef.jpg"), placeholderImage: nil, options: .avoidAutoSetImage, completed: nil)
        //cell.imgView.sd_setImage(with: URL(string: "https://open.twtstudio.com/imgcache/756dcf1f1c15e7716b4725eb85ae5283.jpg"), placeholderImage: nil, options: .avoidAutoSetImage, completed: nil)
     
        cell.imgView.downloadImage(from: (self.newsData?[indexPath.row].NewsImagePath!)!)
       
        
        return cell
    }
    //Cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消点击状态
        newsTableView?.deselectRow(at: indexPath, animated: true)
        //页面传值
        let vc = NewsDetailViewController()
        vc.indexToTitle = self.newsData![indexPath.row].NewsIndex!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIImageView {
    
    func downloadImage(from url: String){
      
        var urlRequest: URLRequest!
        if url == "" {
            urlRequest = URLRequest(url: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510652591944&di=24cf1c993dcefe10c18635b07ebbd5b0&imgtype=0&src=http%3A%2F%2Fimage.lxway.com%2Fupload%2F3%2F88%2F38834e9134078645932230dbe261b4ab.jpg")!)
        } else {
            urlRequest = URLRequest(url: URL(string: url)!)
        }
        //var urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
    
}
