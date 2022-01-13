//
//  CollectionViewCell.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit
import Firebase

class ProfileVCCell: UITableViewCell {
    
   

//
//    var userName: UILabel = {
//        let userName = UILabel()
//        userName.text = "name"
//        userName.textColor = .black
//        return userName
//    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "F"
        label.textColor = .black
        return label
    }()
    
    var share: UIButton = {
        let share = UIButton()
        share.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        share.tintColor = .black
        return share
    }()
//
//    var rateImage =  UIImageView ()
//
//
//    var rate: UIButton = {
//        let rate = UIButton()
//        rate.setTitle("0", for: .normal)
//        rate.setTitleColor(.black, for: .normal)
//        return rate
//    }()
    
    var rate: UIButton = {
        let rate = UIButton()
        rate.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        rate.tintColor = .black
//        rate.addTarget(self, action: #selector(rateCount), for: .touchUpInside)
        return rate
    }()
    
    var rateNum: UIButton = {
        let rateNum = UIButton()
        rateNum.setTitle("0", for: .normal)
        rateNum.setTitleColor(.black, for: .normal)
        return rateNum
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(titleLabel)
//      addSubview(userImage)
//        addSubview(userName)
        addSubview(share)
        addSubview(rate)
        addSubview(rateNum)
        
//        userImage.frame = CGRect(x: 20, y: 10, width: 20, height: 20)
//        userImage.image = UIImage(systemName: "person")
        
        
      let cellFont = UIFont(name: titleLabel.font.fontName, size: 13)
        titleLabel.font = cellFont
//        userName.font = cellFont
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 40, y: contentView.frame.size.height - 50, width: contentView.frame.width - 5, height: 20)
        
//        userName.frame = CGRect(x: 20, y: contentView.frame.size.height - 30, width: contentView.frame.width - 5, height: 20)
        
        rateNum.frame = CGRect(x: 250, y: contentView.frame.size.height - 30, width: contentView.frame.width - 15, height: 15)
        
        share.frame = CGRect(x: 130, y: contentView.frame.size.height - 60, width: contentView.frame.width - 3, height: 10)
        
        rate.frame = CGRect(x: 130, y: contentView.frame.size.height - 30, width: contentView.frame.width - 15, height: 15)
        
    }
    
    
   

}
