//
//  UExCell.swift
//  Qim
//
//  Created by Badreah Saad on 13/01/2022.
//

import UIKit

class UExCell: UITableViewCell {

    
    var userImage =  UIImageView ()
   
    var userName: UILabel = {
        let userName = UILabel()
        userName.text = "name"
        userName.textColor = .black
        return userName
    }()
    
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
    
    var rateImage =  UIImageView ()

    
    var rate: UIButton = {
        let rate = UIButton()
        rate.setTitle("A", for: .normal)
        rate.setTitleColor(.black, for: .normal)
        return rate
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      addSubview(titleLabel)
      addSubview(userImage)
        addSubview(userName)
        addSubview(share)
        addSubview(rate)
        addSubview(rateImage)
        
        userImage.frame = CGRect(x: 20, y: 10, width: 20, height: 20)
        userImage.image = UIImage(systemName: "person")
        
        rateImage.frame = CGRect(x: 320, y: 40, width: 15, height: 15)
        rateImage.image = UIImage(systemName: "hand.thumbsup.fill")
        
      let cellFont = UIFont(name: titleLabel.font.fontName, size: 13)
        titleLabel.font = cellFont
        userName.font = cellFont
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 90, y: contentView.frame.size.height - 50, width: contentView.frame.width - 5, height: 20)
        
        userName.frame = CGRect(x: 20, y: contentView.frame.size.height - 30, width: contentView.frame.width - 5, height: 20)
        
        share.frame = CGRect(x: 150, y: contentView.frame.size.height - 50, width: contentView.frame.width - 3, height: 10)
        
        rate.frame = CGRect(x: 130, y: contentView.frame.size.height - 20, width: contentView.frame.width - 1, height: 1)
        
    }

    



}
