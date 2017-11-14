//
//  NewsTableViewCell.swift
//  NewsDemo
//
//  Created by 侯钦瀚 on 2017/11/12.
//  Copyright © 2017年 HouQinhan. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var subjectLabel: UILabel!
    var imgView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel = UILabel(frame: CGRect(x: 150, y: 0, width: UIScreen.main.bounds.width - 150, height: 100))
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.italicSystemFont(ofSize: 18)
        
        subjectLabel = UILabel(frame: CGRect(x: 150, y: 20, width: UIScreen.main.bounds.width - 150, height: 200))
        subjectLabel.textAlignment = .left
        subjectLabel.numberOfLines = 2
        subjectLabel.font = UIFont.italicSystemFont(ofSize: 14)
        
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        //imgView = UIImageView()
        
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subjectLabel)
        }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
